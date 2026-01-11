import Foundation
import Combine

/// File system observer for monitoring property changes
class FileSystemObserver: ObservableObject {
    private var fileDescriptor: CInt = -1
    private var dispatchSource: DispatchSourceFileSystemObject?
    private let watchedDirectory: URL
    @Published var lastModified: Date = Date()
    
    var onChange: (() -> Void)?
    
    init(directory: URL) {
        self.watchedDirectory = directory
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    private func startMonitoring() {
        // Create directory if it doesn't exist
        try? FileManager.default.createDirectory(at: watchedDirectory, withIntermediateDirectories: true)
        
        // Open the directory for monitoring
        fileDescriptor = open(watchedDirectory.path, O_EVTONLY)
        guard fileDescriptor >= 0 else {
            print("Failed to open directory for monitoring: \(watchedDirectory.path)")
            return
        }
        
        // Create dispatch source
        dispatchSource = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: [.write, .delete, .rename, .extend],
            queue: DispatchQueue.global(qos: .utility)
        )
        
        dispatchSource?.setEventHandler { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.lastModified = Date()
                self.onChange?()
            }
        }
        
        dispatchSource?.setCancelHandler { [weak self] in
            guard let self = self else { return }
            if self.fileDescriptor >= 0 {
                close(self.fileDescriptor)
                self.fileDescriptor = -1
            }
        }
        
        dispatchSource?.resume()
    }
    
    private func stopMonitoring() {
        dispatchSource?.cancel()
        dispatchSource = nil
    }
    
    func readProperty(_ propertyName: String) -> String? {
        let fileURL = watchedDirectory.appendingPathComponent(propertyName)
        return try? String(contentsOf: fileURL, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func writeProperty(_ propertyName: String, value: String) {
        let fileURL = watchedDirectory.appendingPathComponent(propertyName)
        try? value.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}

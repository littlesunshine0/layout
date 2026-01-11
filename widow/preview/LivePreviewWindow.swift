import SwiftUI

/// Integrated live preview with terminal, chat, code view, and project navigator
struct LivePreviewWindow: View {
    @StateObject private var propertyMapper: PropertyMapper
    @State private var selectedInterface: InterfaceType = .preview
    @State private var terminalOutput: [String] = ["Terminal ready. Try: echo '0.5' > WindowAlphaValue"]
    @State private var terminalInput: String = ""
    @State private var chatMessages: [ChatMessage] = []
    @State private var chatInput: String = ""
    @State private var codeContent: String = ""
    @State private var selectedFile: String = "WindowTitle"
    
    enum InterfaceType: String, CaseIterable {
        case preview = "Preview"
        case terminal = "Terminal"
        case chat = "Chat"
        case code = "Code"
        case navigator = "Navigator"
    }
    
    init(projectPath: String) {
        let propertiesURL = URL(fileURLWithPath: projectPath)
            .appendingPathComponent("properties")
        _propertyMapper = StateObject(wrappedValue: PropertyMapper(propertiesDirectory: propertiesURL))
    }
    
    var body: some View {
        HSplitView {
            // Project Navigator (left sidebar)
            projectNavigatorView
                .frame(minWidth: 200, idealWidth: 250)
            
            // Main content area
            VStack(spacing: 0) {
                // Interface selector
                Picker("Interface", selection: $selectedInterface) {
                    ForEach(InterfaceType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Divider()
                
                // Content area
                Group {
                    switch selectedInterface {
                    case .preview:
                        livePreviewView
                    case .terminal:
                        terminalView
                    case .chat:
                        chatView
                    case .code:
                        codeEditorView
                    case .navigator:
                        projectNavigatorView
                    }
                }
            }
        }
        .frame(minWidth: 800, minHeight: 600)
    }
    
    // MARK: - Live Preview
    private var livePreviewView: some View {
        VStack {
            Text("Live Window Preview")
                .font(.title)
                .padding()
            
            // Mock window preview
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .opacity(propertyMapper.alphaValue)
                    .frame(
                        width: propertyMapper.frameWidth / 2,
                        height: propertyMapper.frameHeight / 2
                    )
                    .border(Color.black, width: 2)
                
                VStack {
                    Text(propertyMapper.windowTitle)
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Size: \(Int(propertyMapper.frameWidth)) × \(Int(propertyMapper.frameHeight))")
                        Text("Position: (\(Int(propertyMapper.frameX)), \(Int(propertyMapper.frameY)))")
                        Text("Alpha: \(String(format: "%.2f", propertyMapper.alphaValue))")
                    }
                    .font(.caption)
                    .padding()
                }
            }
            .padding()
            
            // Quick controls
            VStack(spacing: 12) {
                HStack {
                    Text("Opacity:")
                    Slider(value: $propertyMapper.alphaValue, in: 0...1)
                    Text(String(format: "%.2f", propertyMapper.alphaValue))
                        .frame(width: 40)
                }
                
                TextField("Window Title", text: $propertyMapper.windowTitle)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
        }
    }
    
    // MARK: - Terminal View
    private var terminalView: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(Array(terminalOutput.enumerated()), id: \.offset) { _, line in
                        Text(line)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.black)
            
            Divider()
            
            HStack {
                Text("$")
                    .foregroundColor(.green)
                    .font(.system(.body, design: .monospaced))
                TextField("Enter command...", text: $terminalInput)
                    .textFieldStyle(.plain)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.green)
                    .onSubmit {
                        let handler = TerminalHandler()
                        let result = handler.execute(terminalInput)
                        terminalOutput.append("$ \(terminalInput)")
                        terminalOutput.append(result)
                        terminalInput = ""
                    }
            }
            .padding()
            .background(Color.black)
        }
    }
    
    // MARK: - Chat View
    private var chatView: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(chatMessages) { message in
                        ChatBubble(message: message)
                    }
                }
                .padding()
            }
            
            Divider()
            
            HStack {
                TextField("Ask about window properties...", text: $chatInput)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        sendChatMessage()
                    }
                Button("Send") {
                    sendChatMessage()
                }
            }
            .padding()
        }
    }
    
    // MARK: - Code Editor View
    private var codeEditorView: some View {
        VStack {
            HStack {
                Text("Editing: \(selectedFile)")
                    .font(.headline)
                Spacer()
                Button("Save") {
                    saveCodeContent()
                }
            }
            .padding()
            
            TextEditor(text: $codeContent)
                .font(.system(.body, design: .monospaced))
                .padding(4)
                .border(Color.gray, width: 1)
                .padding()
        }
        .onAppear {
            loadCodeContent()
        }
    }
    
    // MARK: - Project Navigator
    private var projectNavigatorView: some View {
        List {
            Section("Properties") {
                NavigationLink(destination: Text("Details")) {
                    Label("WindowTitle", systemImage: "textformat")
                }
                .onTapGesture {
                    selectedFile = "WindowTitle"
                    selectedInterface = .code
                    loadCodeContent()
                }
                
                NavigationLink(destination: Text("Details")) {
                    Label("WindowFrame", systemImage: "rectangle.resize.vertical")
                }
                .onTapGesture {
                    selectedFile = "WindowFrame"
                    selectedInterface = .code
                    loadCodeContent()
                }
                
                NavigationLink(destination: Text("Details")) {
                    Label("WindowAlphaValue", systemImage: "opacity")
                }
                .onTapGesture {
                    selectedFile = "WindowAlphaValue"
                    selectedInterface = .code
                    loadCodeContent()
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Project")
    }
    
    // MARK: - Helper Functions
    private func executeTerminalCommand(_ command: String) {
        terminalOutput.append("$ \(command)")
        
        // Parse simple file write commands
        if command.contains(">") {
            let parts = command.components(separatedBy: ">")
            if parts.count == 2 {
                let value = parts[0].trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "\"", with: "")
                let file = parts[1].trimmingCharacters(in: .whitespaces)
                
                // Write to property
                if file == "WindowAlphaValue", let alpha = Double(value) {
                    propertyMapper.alphaValue = alpha
                    terminalOutput.append("✓ Updated \(file) to \(value)")
                } else if file == "WindowTitle" {
                    propertyMapper.windowTitle = value
                    terminalOutput.append("✓ Updated \(file) to \(value)")
                } else {
                    terminalOutput.append("⚠ Unknown property: \(file)")
                }
            }
        } else {
            terminalOutput.append("⚠ Unsupported command format")
        }
    }
    
    private func sendChatMessage() {
        guard !chatInput.isEmpty else { return }
        
        chatMessages.append(ChatMessage(text: chatInput, isUser: true))
        
        // Use ChatHandler for natural language processing
        let handler = ChatHandler()
        let response = handler.process(chatInput)
        chatMessages.append(ChatMessage(text: response, isUser: false))
        
        chatInput = ""
    }
    
    private func processChatMessage(_ message: String) -> String {
        let handler = ChatHandler()
        return handler.process(message)
    }
    
    private func loadCodeContent() {
        switch selectedFile {
        case "WindowTitle":
            codeContent = propertyMapper.windowTitle
        case "WindowAlphaValue":
            codeContent = "\(propertyMapper.alphaValue)"
        case "WindowFrame":
            codeContent = "x:\(propertyMapper.frameX),y:\(propertyMapper.frameY),width:\(propertyMapper.frameWidth),height:\(propertyMapper.frameHeight)"
        default:
            codeContent = "// Property file content"
        }
    }
    
    private func saveCodeContent() {
        switch selectedFile {
        case "WindowTitle":
            propertyMapper.windowTitle = codeContent
        case "WindowAlphaValue":
            if let alpha = Double(codeContent) {
                propertyMapper.alphaValue = alpha
            }
        default:
            break
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let timestamp = Date()
}

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            VStack(alignment: message.isUser ? .trailing : .leading) {
                Text(message.text)
                    .padding(10)
                    .background(message.isUser ? Color.blue : Color.gray.opacity(0.3))
                    .foregroundColor(message.isUser ? .white : .primary)
                    .cornerRadius(12)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            if !message.isUser { Spacer() }
        }
    }
}

#Preview {
    LivePreviewWindow(projectPath: "/workspaces/layout/Projects/MyNewApp/layout/widow")
}

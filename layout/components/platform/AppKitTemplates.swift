import Foundation

// MARK: - AppKit Component Templates

/// Pre-built AppKit component templates for macOS
@available(macOS 10.15, *)
struct AppKitTemplates {
    
    // MARK: - Card Component
    
    static func cardViewCode(model: CardModel, card: CardModel.Card) -> String {
        """
        import Cocoa
        
        class CardView: NSView {
            
            // MARK: - UI Components
            
            private let imageView: NSImageView = {
                let iv = NSImageView()
                iv.imageScaling = .scaleProportionallyUpOrDown
                return iv
            }()
            
            private let titleField: NSTextField = {
                let field = NSTextField(labelWithString: "")
                field.font = NSFont.systemFont(ofSize: 17, weight: .semibold)
                field.textColor = .white
                field.lineBreakMode = .byWordWrapping
                field.maximumNumberOfLines = 2
                return field
            }()
            
            private let subtitleField: NSTextField = {
                let field = NSTextField(labelWithString: "")
                field.font = NSFont.systemFont(ofSize: 13)
                field.textColor = .systemGray
                field.lineBreakMode = .byTruncatingTail
                field.maximumNumberOfLines = 1
                return field
            }()
            
            private let stackView: NSStackView = {
                let sv = NSStackView()
                sv.orientation = .vertical
                sv.spacing = \(model.spacing)
                sv.alignment = .leading
                sv.distribution = .fill
                return sv
            }()
            
            // MARK: - Initialization
            
            override init(frame frameRect: NSRect) {
                super.init(frame: frameRect)
                setupUI()
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            // MARK: - Setup
            
            private func setupUI() {
                wantsLayer = true
                
                if let layer = layer {
                    layer.backgroundColor = NSColor(hex: "\(model.backgroundColor)").cgColor
                    layer.cornerRadius = \(model.cornerRadius)
                    layer.borderWidth = \(model.borderWidth)
                    layer.borderColor = NSColor(hex: "\(model.borderColor)").cgColor
                    
                    if \(model.shadowEnabled) {
                        layer.shadowColor = NSColor(hex: "\(model.shadowColor)").cgColor
                        layer.shadowRadius = \(model.shadowRadius)
                        layer.shadowOpacity = Float(\(model.shadowOpacity))
                        layer.shadowOffset = .zero
                    }
                }
                
                addSubview(stackView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    stackView.topAnchor.constraint(equalTo: topAnchor, constant: \(model.padding)),
                    stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: \(model.padding)),
                    stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -\(model.padding)),
                    stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -\(model.padding))
                ])
                
                stackView.addArrangedSubview(imageView)
                stackView.addArrangedSubview(titleField)
                stackView.addArrangedSubview(subtitleField)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.heightAnchor.constraint(equalToConstant: \(model.imageHeight)).isActive = true
                imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            }
            
            // MARK: - Configuration
            
            func configure(with card: CardModel.Card) {
                titleField.stringValue = card.title
                subtitleField.stringValue = card.subtitle ?? ""
                
                if let imageName = card.imageName {
                    imageView.image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)
                }
            }
            
            // MARK: - Hover Effect
            
            override func updateTrackingAreas() {
                super.updateTrackingAreas()
                
                trackingAreas.forEach { removeTrackingArea($0) }
                
                let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeInKeyWindow]
                let trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
                addTrackingArea(trackingArea)
            }
            
            override func mouseEntered(with event: NSEvent) {
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.2
                    animator().scaleUnitSquare(to: NSSize(width: \(model.hoverScale), height: \(model.hoverScale)))
                }
            }
            
            override func mouseExited(with event: NSEvent) {
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.2
                    animator().scaleUnitSquare(to: NSSize(width: 1.0, height: 1.0))
                }
            }
        }
        
        // MARK: - NSColor Extension
        
        extension NSColor {
            convenience init(hex: String) {
                let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
                var int: UInt64 = 0
                Scanner(string: hex).scanHexInt64(&int)
                let r, g, b: UInt64
                r = (int >> 16) & 0xFF
                g = (int >> 8) & 0xFF
                b = int & 0xFF
                
                self.init(
                    red: CGFloat(r) / 255,
                    green: CGFloat(g) / 255,
                    blue: CGFloat(b) / 255,
                    alpha: 1
                )
            }
        }
        """
    }
    
    // MARK: - Path Bar Component
    
    static func pathBarCode() -> String {
        """
        import Cocoa
        
        class PathBarView: NSView {
            
            private let pathControl: NSPathControl = {
                let pc = NSPathControl()
                pc.pathStyle = .standard
                pc.backgroundColor = .clear
                return pc
            }()
            
            override init(frame frameRect: NSRect) {
                super.init(frame: frameRect)
                setupUI()
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func setupUI() {
                addSubview(pathControl)
                pathControl.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    pathControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                    pathControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                    pathControl.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
            }
            
            func setPath(_ url: URL) {
                pathControl.url = url
            }
        }
        """
    }
    
    // MARK: - Split View Controller
    
    static func splitViewCode() -> String {
        """
        import Cocoa
        
        class MainSplitViewController: NSSplitViewController {
            
            private let sidebarVC = SidebarViewController()
            private let contentVC = ContentViewController()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                setupSplitView()
            }
            
            private func setupSplitView() {
                // Sidebar
                let sidebarItem = NSSplitViewItem(viewController: sidebarVC)
                sidebarItem.canCollapse = false
                sidebarItem.minimumThickness = 220
                sidebarItem.maximumThickness = 300
                
                // Content
                let contentItem = NSSplitViewItem(viewController: contentVC)
                contentItem.canCollapse = false
                
                addSplitViewItem(sidebarItem)
                addSplitViewItem(contentItem)
            }
        }
        
        class SidebarViewController: NSViewController {
            override func loadView() {
                view = NSView()
                view.wantsLayer = true
                view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
            }
        }
        
        class ContentViewController: NSViewController {
            override func loadView() {
                view = NSView()
                view.wantsLayer = true
                view.layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
            }
        }
        """
    }
    
    // MARK: - Table View
    
    static func tableViewCode() -> String {
        """
        import Cocoa
        
        class CardTableViewController: NSViewController {
            
            private var tableView: NSTableView!
            private var scrollView: NSScrollView!
            private var cards: [CardModel.Card] = []
            
            override func loadView() {
                view = NSView()
                setupTableView()
            }
            
            private func setupTableView() {
                scrollView = NSScrollView()
                scrollView.hasVerticalScroller = true
                scrollView.autohidesScrollers = true
                
                tableView = NSTableView()
                tableView.delegate = self
                tableView.dataSource = self
                tableView.headerView = nil
                tableView.usesAlternatingRowBackgroundColors = true
                
                let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("CardColumn"))
                column.title = "Cards"
                tableView.addTableColumn(column)
                
                scrollView.documentView = tableView
                view.addSubview(scrollView)
                
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
            }
        }
        
        extension CardTableViewController: NSTableViewDataSource {
            func numberOfRows(in tableView: NSTableView) -> Int {
                return cards.count
            }
        }
        
        extension CardTableViewController: NSTableViewDelegate {
            func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
                let card = cards[row]
                let cellView = NSTableCellView()
                
                let textField = NSTextField(labelWithString: card.title)
                cellView.addSubview(textField)
                cellView.textField = textField
                
                return cellView
            }
        }
        """
    }
}

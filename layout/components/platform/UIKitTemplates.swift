import Foundation

// MARK: - UIKit Component Templates

/// Pre-built UIKit component templates for iOS/tvOS
@available(iOS 13.0, tvOS 13.0, *)
struct UIKitTemplates {
    
    // MARK: - Card Component
    
    static func cardViewCode(model: CardModel, card: CardModel.Card) -> String {
        """
        import UIKit
        
        class CardView: UIView {
            
            // MARK: - UI Components
            
            private let imageView: UIImageView = {
                let iv = UIImageView()
                iv.contentMode = .scaleAspectFill
                iv.clipsToBounds = true
                iv.layer.cornerRadius = 8
                return iv
            }()
            
            private let titleLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont.preferredFont(forTextStyle: .headline)
                label.textColor = .white
                label.numberOfLines = 2
                return label
            }()
            
            private let subtitleLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont.preferredFont(forTextStyle: .subheadline)
                label.textColor = .systemGray
                label.numberOfLines = 1
                return label
            }()
            
            private let stackView: UIStackView = {
                let sv = UIStackView()
                sv.axis = .vertical
                sv.spacing = \(model.spacing)
                sv.alignment = .fill
                sv.distribution = .fill
                return sv
            }()
            
            // MARK: - Initialization
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                setupUI()
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            // MARK: - Setup
            
            private func setupUI() {
                backgroundColor = UIColor(hex: "\(model.backgroundColor)")
                layer.cornerRadius = \(model.cornerRadius)
                layer.borderWidth = \(model.borderWidth)
                layer.borderColor = UIColor(hex: "\(model.borderColor)").cgColor
                
                if \(model.shadowEnabled) {
                    layer.shadowColor = UIColor(hex: "\(model.shadowColor)").cgColor
                    layer.shadowRadius = \(model.shadowRadius)
                    layer.shadowOpacity = Float(\(model.shadowOpacity))
                    layer.shadowOffset = .zero
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
                stackView.addArrangedSubview(titleLabel)
                stackView.addArrangedSubview(subtitleLabel)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.heightAnchor.constraint(equalToConstant: \(model.imageHeight)).isActive = true
            }
            
            // MARK: - Configuration
            
            func configure(with card: CardModel.Card) {
                titleLabel.text = card.title
                subtitleLabel.text = card.subtitle
                
                if let imageName = card.imageName {
                    imageView.image = UIImage(systemName: imageName)
                }
            }
        }
        
        // MARK: - UIColor Extension
        
        extension UIColor {
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
    
    // MARK: - Navigation Component
    
    static func navigationCode() -> String {
        """
        import UIKit
        
        class NavigationViewController: UIViewController {
            
            private let navigationBar: UINavigationBar = {
                let bar = UINavigationBar()
                bar.isTranslucent = false
                return bar
            }()
            
            private let tabBar: UITabBarController = {
                let tb = UITabBarController()
                return tb
            }()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                setupNavigation()
            }
            
            private func setupNavigation() {
                view.addSubview(navigationBar)
                navigationBar.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            }
        }
        """
    }
    
    // MARK: - TableView for Lists
    
    static func tableViewCode() -> String {
        """
        import UIKit
        
        class CardTableViewController: UITableViewController {
            
            private var cards: [CardModel.Card] = []
            
            override func viewDidLoad() {
                super.viewDidLoad()
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            }
            
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return cards.count
            }
            
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                let card = cards[indexPath.row]
                cell.textLabel?.text = card.title
                cell.detailTextLabel?.text = card.subtitle
                return cell
            }
        }
        """
    }
}

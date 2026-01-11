import Foundation

// MARK: - SwiftUI Component Templates

/// Pre-built SwiftUI component templates for all platforms
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
struct SwiftUITemplates {
    
    // MARK: - Card Component
    
    static func cardViewCode(model: CardModel) -> String {
        """
        import SwiftUI
        
        struct CardView: View {
            let card: CardModel.Card
            @State private var isHovered = false
            
            var body: some View {
                VStack(alignment: .leading, spacing: \(model.spacing)) {
                    // Image
                    if let imageName = card.imageName {
                        Image(systemName: imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: \(model.imageHeight))
                            .clipped()
                            .cornerRadius(8)
                    }
                    
                    // Title
                    Text(card.title)
                        .font(.\(model.titleFont))
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    // Subtitle
                    if let subtitle = card.subtitle {
                        Text(subtitle)
                            .font(.\(model.subtitleFont))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                }
                .padding(\(model.padding))
                .frame(width: \(model.width), height: \(model.height))
                .background(Color(hex: "\(model.backgroundColor)"))
                .cornerRadius(\(model.cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: \(model.cornerRadius))
                        .stroke(Color(hex: "\(model.borderColor)"), lineWidth: \(model.borderWidth))
                )
                .shadow(
                    color: Color(hex: "\(model.shadowColor)").opacity(\(model.shadowOpacity)),
                    radius: \(model.shadowRadius)
                )
                .scaleEffect(isHovered ? \(model.hoverScale) : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isHovered)
                .onHover { hovering in
                    isHovered = hovering
                }
            }
        }
        
        // MARK: - Color Extension
        
        extension Color {
            init(hex: String) {
                let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
                var int: UInt64 = 0
                Scanner(string: hex).scanHexInt64(&int)
                let r, g, b: UInt64
                r = (int >> 16) & 0xFF
                g = (int >> 8) & 0xFF
                b = int & 0xFF
                
                self.init(
                    .sRGB,
                    red: Double(r) / 255,
                    green: Double(g) / 255,
                    blue:  Double(b) / 255,
                    opacity: 1
                )
            }
        }
        
        // MARK: - Preview
        
        struct CardView_Previews: PreviewProvider {
            static var previews: some View {
                CardView(card: CardModel.mockCards()[0])
                    .preferredColorScheme(.dark)
            }
        }
        """
    }
    
    // MARK: - Grid Layout
    
    static func gridViewCode() -> String {
        """
        import SwiftUI
        
        struct CardGridView: View {
            let cards: [CardModel.Card]
            let columns: Int
            
            var gridColumns: [GridItem] {
                Array(repeating: GridItem(.flexible(), spacing: 16), count: columns)
            }
            
            var body: some View {
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(cards) { card in
                            CardView(card: card)
                        }
                    }
                    .padding()
                }
            }
        }
        """
    }
    
    // MARK: - List Layout
    
    static func listViewCode() -> String {
        """
        import SwiftUI
        
        struct CardListView: View {
            let cards: [CardModel.Card]
            @State private var selectedCard: CardModel.Card?
            
            var body: some View {
                List(cards, selection: $selectedCard) { card in
                    HStack {
                        if let imageName = card.imageName {
                            Image(systemName: imageName)
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(card.title)
                                .font(.headline)
                            
                            if let subtitle = card.subtitle {
                                Text(subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        if card.isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
        }
        """
    }
    
    // MARK: - Navigation
    
    static func navigationViewCode() -> String {
        """
        import SwiftUI
        
        struct MainNavigationView: View {
            @StateObject private var coordinator = LayoutCoordinator(useMockData: true)
            
            var body: some View {
                NavigationView {
                    // Sidebar
                    NavigationSidebarView()
                        .frame(minWidth: 220, maxWidth: 300)
                    
                    // Content
                    ContentView()
                        .frame(minWidth: 400)
                }
                .environmentObject(coordinator)
            }
        }
        
        struct NavigationSidebarView: View {
            @EnvironmentObject var coordinator: LayoutCoordinator
            
            var body: some View {
                List(selection: $coordinator.navigation.selectedItem) {
                    ForEach(coordinator.navigation.items) { item in
                        NavigationLink(item.name, tag: item.id, selection: $coordinator.navigation.selectedItem) {
                            Text(item.name)
                        }
                    }
                }
                .listStyle(SidebarListStyle())
            }
        }
        """
    }
    
    // MARK: - Tab View
    
    static func tabViewCode() -> String {
        """
        import SwiftUI
        
        struct MainTabView: View {
            @State private var selectedTab = 0
            
            var body: some View {
                TabView(selection: $selectedTab) {
                    CardGridView(cards: CardModel.mockCards(), columns: 3)
                        .tabItem {
                            Label("Projects", systemImage: "folder")
                        }
                        .tag(0)
                    
                    CardListView(cards: CardModel.mockCards())
                        .tabItem {
                            Label("Packages", systemImage: "shippingbox")
                        }
                        .tag(1)
                    
                    Text("Settings")
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                        .tag(2)
                }
            }
        }
        """
    }
    
    // MARK: - Status Bar
    
    static func statusBarCode() -> String {
        """
        import SwiftUI
        
        struct StatusBarView: View {
            let leftItems: [StatusItem]
            let centerItems: [StatusItem]
            let rightItems: [StatusItem]
            
            var body: some View {
                HStack {
                    // Left
                    HStack(spacing: 12) {
                        ForEach(leftItems) { item in
                            StatusItemView(item: item)
                        }
                    }
                    
                    Spacer()
                    
                    // Center
                    HStack(spacing: 12) {
                        ForEach(centerItems) { item in
                            StatusItemView(item: item)
                        }
                    }
                    
                    Spacer()
                    
                    // Right
                    HStack(spacing: 12) {
                        ForEach(rightItems) { item in
                            StatusItemView(item: item)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(hex: "#1C1C1E"))
            }
        }
        
        struct StatusItemView: View {
            let item: StatusItem
            
            var body: some View {
                HStack(spacing: 4) {
                    if let icon = item.icon {
                        Image(systemName: icon)
                            .font(.caption)
                    }
                    Text(item.text)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
        }
        
        struct StatusItem: Identifiable {
            let id = UUID()
            let icon: String?
            let text: String
        }
        """
    }
    
    // MARK: - Path Bar
    
    static func pathBarCode() -> String {
        """
        import SwiftUI
        
        struct PathBarView: View {
            let segments: [PathSegment]
            let onSelect: (PathSegment) -> Void
            
            var body: some View {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(Array(segments.enumerated()), id: \\.offset) { index, segment in
                            Button(action: {
                                onSelect(segment)
                            }) {
                                HStack(spacing: 4) {
                                    if let icon = segment.icon {
                                        Image(systemName: icon)
                                            .font(.caption)
                                    }
                                    Text(segment.name)
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            if index < segments.count - 1 {
                                Image(systemName: "chevron.right")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .frame(height: 32)
                .background(Color(hex: "#1C1C1E"))
            }
        }
        
        struct PathSegment: Identifiable {
            let id = UUID()
            let name: String
            let path: String
            let icon: String?
        }
        """
    }
    
    // MARK: - Complete App
    
    static func completeAppCode() -> String {
        """
        import SwiftUI
        
        @main
        struct LayoutApp: App {
            @StateObject private var coordinator = LayoutCoordinator(useMockData: true)
            
            var body: some Scene {
                WindowGroup {
                    ContentView()
                        .environmentObject(coordinator)
                        .frame(minWidth: 1200, minHeight: 800)
                }
            }
        }
        
        struct ContentView: View {
            @EnvironmentObject var coordinator: LayoutCoordinator
            
            var body: some View {
                VStack(spacing: 0) {
                    // Title Bar
                    TitleBarView()
                    
                    HStack(spacing: 0) {
                        // Navigation
                        NavigationView()
                            .frame(width: coordinator.navigation.isExpanded ? 220 : 72)
                        
                        // Category
                        CategoryView()
                            .frame(width: 200)
                        
                        // Content
                        MainContentView()
                    }
                    
                    // Status Bar
                    StatusBarView(
                        leftItems: [],
                        centerItems: [],
                        rightItems: []
                    )
                }
                .overlay(
                    // Floating Panels
                    PanelsOverlay()
                )
            }
        }
        
        struct TitleBarView: View {
            var body: some View {
                HStack {
                    Image(systemName: "shippingbox.fill")
                    Text("FlowKit Layout")
                        .font(.headline)
                    Spacer()
                }
                .padding()
                .frame(height: 52)
                .background(Color(hex: "#1C1C1E"))
            }
        }
        
        struct NavigationView: View {
            var body: some View {
                VStack {
                    // Navigation items
                }
                .background(Color(hex: "#2C2C2E"))
            }
        }
        
        struct CategoryView: View {
            var body: some View {
                VStack {
                    // Category items
                }
                .background(Color(hex: "#2C2C2E"))
            }
        }
        
        struct MainContentView: View {
            var body: some View {
                CardGridView(cards: CardModel.mockCards(), columns: 3)
                    .background(Color.black)
            }
        }
        
        struct PanelsOverlay: View {
            var body: some View {
                // Floating panels
                EmptyView()
            }
        }
        """
    }
}

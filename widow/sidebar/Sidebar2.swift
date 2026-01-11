import SwiftUI

/// Secondary sidebar for property groups
struct Sidebar2: View {
    @State private var propertyGroups: [PropertyGroup] = [
        PropertyGroup(name: "Basic", icon: "info.circle"),
        PropertyGroup(name: "Frame & Size", icon: "rectangle.resize.vertical"),
        PropertyGroup(name: "Behavior", icon: "gearshape"),
        PropertyGroup(name: "Appearance", icon: "paintbrush"),
        PropertyGroup(name: "Advanced", icon: "slider.horizontal.3")
    ]
    @State private var selectedGroup: PropertyGroup?
    
    var body: some View {
        List(propertyGroups, selection: $selectedGroup) { group in
            Label(group.name, systemImage: group.icon)
        }
        .navigationTitle("Properties")
    }
}

struct PropertyGroup: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var icon: String
}

#Preview {
    NavigationStack {
        Sidebar2()
    }
}

// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LayoutCLI",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "layout-cli",
            targets: ["LayoutCLI"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "LayoutCLI",
            dependencies: [],
            path: ".",
            sources: [
                "CLI/main.swift",
                "widow/integration/CRUDManager.swift",
                "widow/integration/FlowKitAdapter.swift",
                "widow/integration/KitPackageMapper.swift",
                "widow/integration/FlowKitTerminalCommands.swift",
                "widow/packages/PackageManager.swift"
            ]
        )
    ]
)

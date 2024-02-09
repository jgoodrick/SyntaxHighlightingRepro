// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        platforms: [.iOS]
    )

#endif

let package = Package(
    name: "external-workspace-dependencies",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.7.0")),
    ]
)

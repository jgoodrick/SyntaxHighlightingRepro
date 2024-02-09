// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        baseSettings: .targetSettings,
        platforms: [.iOS]
    )

#endif

let package = Package(
    name: "external-workspace-dependencies",
    dependencies: [
        "athlete-kit-features",
        "shared-architecture",
        "shared-core",
        "shared-dependencies",
    ].map({ .package(path: "Packages/\($0)") })
)

// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        baseSettings: .settings(),
        platforms: [.iOS]
    )

#endif

let package = Package(
    name: "external-workspace-dependencies",
    dependencies: [
        .package(path: "Packages/shared-architecture"),
        .package(path: "Packages/features-package"),
    ]
)

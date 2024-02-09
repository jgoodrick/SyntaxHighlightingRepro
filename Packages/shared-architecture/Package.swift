// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "shared-architecture",
    defaultLocalization: "en",
//    platforms: [
//        .iOS(.v16),
//    ],
    products: [
        .library(name: "ExamplePackageProduct", targets: ["ExamplePackageProduct"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMajor(from: "1.7.0")
        ),
    ],
    targets: [
        .target(name: "ExamplePackageProduct", dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]),
    ]
)

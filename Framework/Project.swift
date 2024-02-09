import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ExampleFrameworkProject",
    targets: [
        .target(
            name: "ExampleFrameworkProject",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.example.framework.target",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture", condition: .none),
            ]
        ),
    ]
)

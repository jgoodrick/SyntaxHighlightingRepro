import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Example",
    organizationName: "Company",
    settings: .settings(),
    targets: [
        .target(
            name: "Example Target",
            destinations: .iOS,
            product: .app,
            productName: "ExampleTarget",
            bundleId: "com.example.target",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Example Framework Target", path: "../Framework", condition: .none),
            ],
            settings: .settings()
        ),
    ],
    schemes: [
        .scheme(
            name: "ExampleScheme",
            shared: true,
            buildAction: .buildAction(
                targets: [
                    "Example Target",
                ]
            ),
            runAction: .runAction(
                configuration: .debug,
                executable: .target("Example Target")
            )
        )
    ]
)

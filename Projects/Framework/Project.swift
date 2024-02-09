import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Example Framework Project",
    organizationName: "Company",
    settings: .settings(),
    targets: [
        .target(
            name: "Example Framework Target",
            destinations: .iOS,
            product: .framework,
            productName: "ExampleFrameworkTarget",
            bundleId: "com.example.framework.target",
            deploymentTargets: .iOS("16.0"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ExamplePackageProduct", condition: .none),
            ],
            settings: .settings()
        ),
    ],
    schemes: [
        .scheme(
            name: "Example Framework Target Scheme",
            shared: true,
            buildAction: .buildAction(
                targets: [
                    "Example Framework Target",
                ]
            )
        )
    ]
)

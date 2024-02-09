import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Athlete Kit",
    organizationName: Company.legalName,
    settings: .projectSettings,
    targets: [
        .target(
            name: Module.Athlete_Kit_Framework_iOS.target,
            destinations: .iOS,
            product: .framework,
            productName: Module.Athlete_Kit_Framework_iOS.product,
            bundleId: Module.Athlete_Kit_Framework_iOS.bundleID,
            deploymentTargets: .minimum_iOS_only,
            sources: .sources(in: "."),
            dependencies: [
                .external(name: Module.Athlete_Kit_Features.library, condition: .none),
            ],
            settings: .targetSettings
//                .apply(.exportingAnXCFrameworkForDistribution()) // uncomment if building for release
                .version(.init(2, 0, 0))
                .build(.string("3"))
        ),
    ],
    schemes: [
        Module.Athlete_Kit_Framework_iOS.frameworkScheme,
    ]
)

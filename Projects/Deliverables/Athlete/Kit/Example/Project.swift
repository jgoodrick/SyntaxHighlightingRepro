import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Athlete Kit Example",
    organizationName: Company.legalName,
    settings: .projectSettings,
    targets: [
        .target(
            name: Module.Athlete_Kit_Framework_Example_App_iOS.target,
            destinations: .iOS,
            product: .app,
            productName: Module.Athlete_Kit_Framework_Example_App_iOS.product,
            bundleId: Module.Athlete_Kit_Framework_Example_App_iOS.bundleID,
            deploymentTargets: .minimum_iOS_only,
            infoPlist: .extendingDefault(
                with:
                    .displayName(.string("Athlete Kit"))
                    .cameraPermissionsMessage()
                    .launchScreenStoryboard()
                    .requiresFullScreen()
                    .orientations(
                        all: .portrait,
                        iPhone: .portrait
                    )
            ),
            sources: .sources(in: "."),
            resources: .resources(in: "."),
            entitlements: Module.Athlete_Kit_Framework_Example_App_iOS.entitlements(in: "."),
            dependencies: [
                .project(target: Module.Athlete_Kit_Framework_iOS.target, path: "../Framework", condition: .none),
            ],
            settings: .targetSettings
                .accentColor()
                .version(.init(2, 0, 0))
                .build(.string("1"))
        ),
    ],
    schemes: [
        Module.Athlete_Kit_Framework_Example_App_iOS.appScheme,
    ]
)

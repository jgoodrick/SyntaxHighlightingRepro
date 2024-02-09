
import ProjectDescription

extension Module {
    public var appScheme: Scheme {
        .scheme(
            name: scheme,
            shared: true,
            buildAction: .buildAction(
                targets: [
                    "\(target)",
                    "\(target)Tests"
                ]
            ),
            testAction: .targets(
                ["\(target)Tests"],
                configuration: .debug
            ),
            runAction: .runAction(
                configuration: .debug,
                executable: .target(target)
            )
        )
    }
    public var frameworkScheme: Scheme {
        .scheme(
            name: scheme,
            shared: true,
            buildAction: .buildAction(
                targets: [
                    "\(target)",
                    "\(target)Tests"
                ]
            ),
            testAction: .targets(
                ["\(target)Tests"],
                configuration: .debug
            )
        )
    }
}

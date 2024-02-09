
import ProjectDescription

public enum Company {}

public extension Company {
    static let legalName: String = "Company, Inc."
    static let shortName: String = "Company"
}

extension Company {
    fileprivate static func explicitBundleID(_ components: String...) -> String {
        explicitBundleID(appendingComponentsOf: components)
    }
    fileprivate static func explicitBundleID(appendingComponentsOf components: [String]) -> String {
        let trailing = components.isEmpty ? "undefined" : components.joined(separator: ".")
        return "\(bundlePrefix).\(trailing)"
    }
    fileprivate static func bundleID(for module: Module) -> String {
        module.bundleID
    }
    public static let bundlePrefix: String = "com.some.bundle.prefix"
}

public extension Module {
    var bundleID: String {
        Company.explicitBundleID(appendingComponentsOf: rawValue.lowercased().components(separatedBy: "_"))
    }
}

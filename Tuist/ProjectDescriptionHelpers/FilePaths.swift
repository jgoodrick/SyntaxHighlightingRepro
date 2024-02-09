
import ProjectDescription

public extension Module {
    func entitlements(in directoryPath: String) -> Entitlements {
        "\(directoryPath)/\(filename).entitlements"
    }
}

public extension SourceFilesList {
    static func sources(in directoryPath: String) -> Self {
        ["\(directoryPath)/Sources/**"]
    }
}

public extension ResourceFileElements {
    static func resources(in directoryPath: String) -> Self {
        ["\(directoryPath)/Resources/**"]
    }
}

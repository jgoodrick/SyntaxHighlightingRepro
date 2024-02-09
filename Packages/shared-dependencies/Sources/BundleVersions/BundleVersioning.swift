
import Architecture
import Foundation

public struct BundleVersioning {
    var bundleVersion: () -> BundleVersion
}

public struct BundleVersion {
    public let version: SemanticVersion
    public let build: Int
}

public struct SemanticVersion {
    public let major: Int
    public let minor: Int?
    public let patch: Int?
}

extension DependencyValues {
    public var bundleVersion: BundleVersioning {
        get { self[BundleVersioning.self] }
        set { self[BundleVersioning.self] = newValue }
    }
}

extension BundleVersioning: DependencyKey {
    public static let liveValue: Self = {
        .init(
            bundleVersion: { .init(version: .init(major: 0, minor: 0, patch: 0), build: 0) }
        )
    }()
}

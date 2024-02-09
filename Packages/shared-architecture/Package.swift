// swift-tools-version: 5.9

import PackageDescription
import _StringProcessing

let package = Package(
    name: "shared-architecture",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
    ],
    products: PackageTarget.allCases.compactMap(\.library),
    dependencies: ExternalPackage.allCases.compactMap(\.asPackageDependency),
    targets: PackageTarget.allCases.map(\.target)
)

enum PackageTarget: String, CaseIterable {
    case Architecture
    case AsyncSubjects
}

enum ExternalPackage: String, CaseIterable {
    //  Facilitates our AsyncSubjects module, as well as debounce and removeDuplicates
    case AsyncAlgorithms = "swift-async-algorithms"
    case ComposableArchitecture = "swift-composable-architecture"
}

enum ExternalTarget: String, CaseIterable {
    // AsyncAlgorithms - transitively depends on swift-collections
    case AsyncAlgorithms
    case ComposableArchitecture
}

extension PackageTarget {
    var internalDependencies: [PackageTarget] {
        switch self {
        case .Architecture:
            return [
                .AsyncSubjects,
            ]
        default: return []
        }
    }
    
    var externalDependencies: [ExternalTarget] {
        switch self {
        case .Architecture:
            return [
                .ComposableArchitecture,
            ]
        case .AsyncSubjects:
            return [
                .AsyncAlgorithms,
            ]
        }
    }
}

extension ExternalTarget {
    var package: ExternalPackage {
        switch self {
            
        case .AsyncAlgorithms:
            return .AsyncAlgorithms

        case .ComposableArchitecture:
            return .ComposableArchitecture
        
        }
    }

}

extension ExternalPackage {
    var asPackageDependency: Package.Dependency? {
        switch self {
        case .AsyncAlgorithms:
            return .package(
                url: "https://github.com/apple/swift-async-algorithms",
                .upToNextMajor(from: "1.0.0")
            )
        case .ComposableArchitecture:
            return .package(
                url: "https://github.com/pointfreeco/swift-composable-architecture",
                .upToNextMajor(from: "1.7.0")
            )
        }
    }
}

extension ExternalTarget {
    var asTargetDependency: Target.Dependency {
        Target.Dependency.product(name: rawValue, package: package.rawValue)
    }
}

extension PackageTarget {
    
    var dependencies: [Target.Dependency] {
        var result = [
            externalDependencies.map(\.asTargetDependency),
            internalDependencies.map(\.asTargetDependency),
        ].flatMap({$0})
        
        targetThisTestTargetShouldTest.map({ result.append($0) })
        
        layoutTargetAssociatedWithThisFeatureTarget.map({ result.append($0) })
                        
        return result
    }
    
    var resources: [Resource] { [] }
    
    var featuresSuffix: String { "Features" }
    var layoutsSuffix: String { "Layouts" }
    var servicesSuffix: String { "Services" }
    var testsSuffix: String { "Tests" }
    
    var features: Bool { rawValue.ends(in: featuresSuffix) }
    var layouts: Bool { rawValue.ends(in: layoutsSuffix) }
    var services: Bool { rawValue.ends(in: servicesSuffix) }
    var tests: Bool { rawValue.ends(in: testsSuffix) }
    
    func `is`(_ specificTarget: PackageTarget) -> Bool {
        self ~= specificTarget
    }
    
    var targetThisTestTargetShouldTest: Target.Dependency? {
        guard tests else { return nil }
        if let feature = PackageTarget(rawValue: rawValue.replacing(testsSuffix, with: featuresSuffix)) {
            return feature.asTargetDependency
        } else if let module = PackageTarget(rawValue: rawValue.replacing(testsSuffix, with: "")) {
            return module.asTargetDependency
        } else {
            return nil
        }
    }
    
    var layoutTargetAssociatedWithThisFeatureTarget: Target.Dependency? {
        guard features else { return nil }
        return PackageTarget(rawValue: rawValue.replacing(featuresSuffix, with: layoutsSuffix))?.asTargetDependency
    }

    var servicesTargetAssociatedWithThisFeatureTarget: Target.Dependency? {
        guard features else { return nil }
        return PackageTarget(rawValue: rawValue.replacing(featuresSuffix, with: servicesSuffix))?.asTargetDependency
    }

    // What modules become available for use outside of this package?
    var library: Product? {
        Product.library(name: libraryName, targets: [targetName])
    }
    
    var target: Target {
        if tests {
            Target.testTarget(
                name: targetName,
                dependencies: dependencies,
                resources: resources
            )
        } else {
            Target.target(
                name: targetName,
                dependencies: dependencies,
                resources: resources
            )
        }
    }
    
    var asTargetDependency: Target.Dependency {
        Target.Dependency.init(stringLiteral: rawValue)
    }
    
    var targetName: String {
        rawValue
    }
    
    var libraryName: String {
        rawValue
    }
    
}

extension String {
    func ends(in suffix: String) -> Bool {
        self.suffix(suffix.count) == suffix
    }
}

// swift-tools-version: 5.9

import PackageDescription
import _StringProcessing

let package = Package(
    name: "shared-dependencies",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
    ],
    products: PackageTarget.allCases.compactMap(\.library),
    dependencies: ExternalPackage.allCases.compactMap(\.asPackageDependency),
    targets: PackageTarget.allCases.map(\.target)
)

enum PackageTarget: String, CaseIterable {
    case BundleVersions
}

enum ExternalPackage: String, CaseIterable {
    case SharedArchitecture = "shared-architecture"
    case SharedCore = "shared-core"
}

enum ExternalTarget: String, CaseIterable {
    case Architecture
    case TaggedValues
}

extension PackageTarget {
    var internalDependencies: [PackageTarget] {
        switch self {
        case .BundleVersions:
            return []
        }
    }
    
    var externalDependencies: [ExternalTarget] {
        switch self {
        case .BundleVersions:
            return [
                .TaggedValues,
            ]
        }
    }
}

extension ExternalTarget {
    var package: ExternalPackage {
        switch self {
        case .Architecture:
            return .SharedArchitecture
        case .TaggedValues:
            return .SharedCore
        }
    }
}

extension ExternalPackage {
    var asPackageDependency: Package.Dependency? {
        switch self {
        default:
            return .package(path: "../\(rawValue)")
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
        
        result.append(ExternalTarget.Architecture.asTargetDependency)
                
        return result
    }
    
    var resources: [Resource] { [] }
    
    var testsSuffix: String { "Tests" }
    
    var tests: Bool { rawValue.ends(in: testsSuffix) }
    
    func `is`(_ specificTarget: PackageTarget) -> Bool {
        switch self {
        case specificTarget: return true
        default: return false
        }
    }
    
    var targetThisTestTargetShouldTest: Target.Dependency? {
        guard tests else { return nil }
        if let module = PackageTarget(rawValue: rawValue.replacing(testsSuffix, with: "")) {
            return module.asTargetDependency
        } else {
            return nil
        }
    }
        
    var library: Product? {
        if tests {
            return nil
        } else {
            return Product.library(name: libraryName, targets: [targetName])
        }
    }
    
    var target: Target {
        if tests {
            return Target.testTarget(
                name: targetName,
                dependencies: dependencies,
                resources: resources
            )
        } else {
            return Target.target(
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

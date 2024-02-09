// swift-tools-version: 5.9

import PackageDescription
import _StringProcessing

let package = Package(
    name: "features-package",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
    ],
    products: PackageTarget.allCases.compactMap(\.library),
    dependencies: ExternalPackage.allCases.compactMap(\.asPackageDependency),
    targets: PackageTarget.allCases.map(\.target)
)

enum PackageTarget: String, CaseIterable {
    case ExamplePackageProduct
}

enum ExternalPackage: String, CaseIterable {
    case SharedArchitecture = "shared-architecture"
}

enum ExternalTarget: String, CaseIterable {
    case Architecture
}

extension PackageTarget {
    var internalDependencies: [PackageTarget] {
        switch self {
        case .ExamplePackageProduct:
            return [
            ]
        }
    }
    
    var externalDependencies: [ExternalTarget] {
        switch self {
        case .ExamplePackageProduct:
            return [
                .Architecture,
            ]
        }
    }
}

extension ExternalTarget {
    var package: ExternalPackage {
        switch self {
        case .Architecture:
            return .SharedArchitecture
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
        Target.Dependency.product(name: rawValue, package: package.rawValue, condition: nil)
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
    
    var resources: [Resource] {
        switch self {
        default:
            return []
        }
    }

    var featuresSuffix: String { "Features" }
    var testsSuffix: String { "Tests" }

    var features: Bool { rawValue.ends(in: featuresSuffix) }
    var tests: Bool { rawValue.ends(in: testsSuffix) }

    func `is`(_ specificTarget: PackageTarget) -> Bool {
        switch self {
        case specificTarget: return true
        default: return false
        }
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

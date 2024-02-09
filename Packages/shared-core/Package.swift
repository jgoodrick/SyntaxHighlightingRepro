// swift-tools-version: 5.9

import PackageDescription
import _StringProcessing

let package = Package(
    name: "shared-core",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
    ],
    products: PackageTarget.allCases.compactMap(\.library),
    targets: PackageTarget.allCases.map(\.target)
)

enum PackageTarget: String, CaseIterable {
    case TaggedValues
}

extension PackageTarget {
    var internalDependencies: [PackageTarget] {
        switch self {
        case .TaggedValues:
            return []
        }
    }
}

extension PackageTarget {
    
    var dependencies: [Target.Dependency] {
        let result = [
            internalDependencies.map(\.asTargetDependency),
        ].flatMap({$0})
        
        return result
    }
    
    var resources: [Resource] { []}
    
    var testsSuffix: String { "Tests" }

    var tests: Bool { rawValue.ends(in: testsSuffix) }

    func `is`(_ specificTarget: PackageTarget) -> Bool {
        switch self {
        case specificTarget: return true
        default: return false
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

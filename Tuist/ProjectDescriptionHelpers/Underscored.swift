
public protocol Underscored: RawRepresentable<String> {}

public extension Underscored {
    var withSpaces: String { rawValue.replacingOccurrences(of: "_", with: " ") }
    var withoutSpaces: String { rawValue.replacingOccurrences(of: "_", with: "") }
    var withUnderscores: String { rawValue }
    var withDashes: String { rawValue.replacingOccurrences(of: "_", with: "-") }
    var pascal: String { withoutSpaces }
    var camel: String { withoutSpaces.firstLowercased }
    var snake: String { rawValue.lowercased() }
    var package: String { withDashes.lowercased() }
    var library: String { withoutSpaces }
    var target: String { withSpaces }
    var scheme: String { withSpaces }
    var product: String { pascal }
    var filename: String { snake }
    func map<T>(_ transform: (Self) -> T) -> T {
        transform(self)
    }
}

extension StringProtocol {
    fileprivate var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}

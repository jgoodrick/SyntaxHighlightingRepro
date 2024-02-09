
import Foundation

// This is a great candidate for converting to a macro
public struct TaggedDate<Tag>: Equatable, Hashable, Sendable, Codable, CustomStringConvertible, RawRepresentable, Identifiable, Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    public var id: Date { rawValue }
    public var rawValue: Date
    
    public init(rawValue: Date) {
        self.rawValue = rawValue
    }
    
    public static func tagged(_ rawValue: Date) -> Self {
        Self.init(rawValue: rawValue)
    }
    
    public var description: String {
        return String(describing: self.rawValue)
    }

    public init(from decoder: Decoder) throws {
        do {
            self.init(rawValue: try decoder.singleValueContainer().decode(Date.self))
        } catch {
            self.init(rawValue: try .init(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.singleValueContainer()
            try container.encode(self.rawValue)
        } catch {
            try self.rawValue.encode(to: encoder)
        }
    }
    
    public func ported<V>() -> TaggedDate<V> {
        .init(rawValue: self.rawValue)
    }
    
}

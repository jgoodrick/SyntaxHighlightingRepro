

import Foundation

// This is a great candidate for converting to a macro
public struct TaggedUInt64<Tag>: Equatable, Hashable, Sendable, Codable, CustomStringConvertible, RawRepresentable, Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
      return lhs.rawValue < rhs.rawValue
    }
    
    public var rawValue: UInt64
    
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
    public static func tagged(_ rawValue: UInt64) -> Self {
        Self.init(rawValue: rawValue)
    }
    
    public var description: String {
        return String(describing: self.rawValue)
    }

    public init(from decoder: Decoder) throws {
        do {
            self.init(rawValue: try decoder.singleValueContainer().decode(UInt64.self))
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
    
    public func ported<V>() -> TaggedUInt64<V> {
        .init(rawValue: self.rawValue)
    }
    
}

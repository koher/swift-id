public protocol IDProtocol: RawRepresentable, Hashable, Sendable, Identifiable, Codable, CustomStringConvertible where RawValue: Hashable & Sendable & Codable & CustomStringConvertible {
    init(rawValue: RawValue)
}

extension IDProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(rawValue: try container.decode(RawValue.self))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    public var description: String {
        rawValue.description
    }

    public var id: Self { self }
}

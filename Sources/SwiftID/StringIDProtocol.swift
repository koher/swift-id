public protocol StringIDProtocol: IDProtocol, ExpressibleByStringInterpolation where RawValue: StringProtocol {}

extension StringIDProtocol {
    public init(stringLiteral value: RawValue.StringLiteralType) {
        self.init(rawValue: RawValue(stringLiteral: value))
    }

    public init(stringInterpolation: RawValue.StringInterpolation) {
        self.init(rawValue: RawValue(stringInterpolation: stringInterpolation))
    }
}

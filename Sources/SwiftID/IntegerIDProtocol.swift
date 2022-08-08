public protocol IntegerIDProtocol: IDProtocol, ExpressibleByIntegerLiteral where RawValue: BinaryInteger {}

extension IntegerIDProtocol {
    public init(integerLiteral value: RawValue.IntegerLiteralType) {
        self.init(rawValue: RawValue(integerLiteral: value))
    }
}

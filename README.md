# SwiftID

Makes it easy to implement custom `ID` types especially when they wrap integer or string types. Custom `ID` types which conform to `IntegerIDProtocol` or `StringIDProtocol` are automatically conform to the following protocols.

- `Hashable`
- `Sendable`
- `Identifiable`
- `Codable`
- `CustomStringConvertible`
- `ExpressibleByIntegerLiteral` or `ExpressibleByStringLiteral`.

```swift
struct User: Identifiable, Sendable, Hashable, Codable {
    let id: ID
    var name: String

    // 🙂 Easy to implement!!
    struct ID: StringIDProtocol {
        let rawValue: String
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
```
```swift
// ExpressibleByStringLiteral
let user = User(id: "abc", name: "Swift")
```
```swift
// CustomStringConvertible
print(user.id) // abc
```
```swift
// Identifiable
let ids: [User.ID] = ["abc"]
_ = ForEach(ids) { id in
    if let user = idToUser[id] {
        Text(user.name)
    }
}
```

## License

MIT

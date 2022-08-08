import XCTest
import SwiftID
import SwiftUI

final class StringIDProtocolTests: XCTestCase {
    func testUsage() async throws {
        // ExpressibleByStringLiteral
        let user = User(id: "abc", name: "Swift")

        // CustomStringConvertible
        print(user.id) // abc
        XCTAssertEqual(user.id.description, "abc")

        // Hashable
        let idToUser: [User.ID: User] = [user.id: user]
        XCTAssertEqual(user, idToUser["abc"])

        // Codable
        let encoded: Data = try JSONEncoder().encode(user)
        let decoded: User = try JSONDecoder().decode(User.self, from: encoded)
        XCTAssertEqual(decoded, user)

        // Sendable
        let task = Task {
            print(user)
        }
        _ = await task.value

        // Identifiable
        let ids: [User.ID] = ["abc"]
        _ = ForEach(ids) { id in
            if let user = idToUser[id] {
                Text(user.name)
            }
        }
    }

    func testExpressibleByStringLiteral() {
        let id: User.ID = "abc"
        XCTAssertEqual(id.rawValue, "abc")
    }

    func testCustomStringConvertible() {
        let id: User.ID = "abc"
        XCTAssertEqual(id.description, "abc")
    }

    func testEquatable() {
        let id: User.ID = "abc"
        XCTAssertTrue(id == "abc")
        XCTAssertFalse(id == "xyz")
    }

    func testHashable() {
        let id: User.ID = "abc"
        XCTAssertEqual(id.hashValue, ("abc" as User.ID).hashValue)
    }

    func testEncodable() throws {
        let id: User.ID = "abc"
        let data = try JSONEncoder().encode(id)
        XCTAssertEqual(String(data: data, encoding: .utf8)!, #""abc""#)
    }

    func testDecodable() throws {
        let data: Data = #""abc""#.data(using: .utf8)!
        let id = try JSONDecoder().decode(User.ID.self, from: data)
        XCTAssertEqual(id, "abc")
    }
}

private struct User: Identifiable, Sendable, Hashable, Codable {
    let id: ID
    var name: String

    struct ID: StringIDProtocol {
        let rawValue: String
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

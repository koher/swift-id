import XCTest
import SwiftID
import SwiftUI

final class IntegerIDProtocolTests: XCTestCase {
    func testUsage() async throws {
        // ExpressibleByStringLiteral
        let user = User(id: 42, name: "Swift")

        // CustomStringConvertible
        print(user.id) // abc
        XCTAssertEqual(user.id.description, "42")

        // Hashable
        let idToUser: [User.ID: User] = [user.id: user]
        XCTAssertEqual(user, idToUser[42])

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
        let ids: [User.ID] = [42]
        _ = ForEach(ids) { id in
            if let user = idToUser[id] {
                Text(user.name)
            }
        }
    }

    func testExpressibleByStringLiteral() {
        let id: User.ID = 42
        XCTAssertEqual(id.rawValue, 42)
    }

    func testCustomStringConvertible() {
        let id: User.ID = 42
        XCTAssertEqual(id.description, "42")
    }

    func testEquatable() {
        let id: User.ID = 42
        XCTAssertTrue(id == 42)
        XCTAssertFalse(id == -1)
    }

    func testHashable() {
        let id: User.ID = 42
        XCTAssertEqual(id.hashValue, (42 as User.ID).hashValue)
    }

    func testEncodable() throws {
        let id: User.ID = 42
        let data = try JSONEncoder().encode(id)
        XCTAssertEqual(String(data: data, encoding: .utf8)!, "42")
    }

    func testDecodable() throws {
        let data: Data = "42".data(using: .utf8)!
        let id = try JSONDecoder().decode(User.ID.self, from: data)
        XCTAssertEqual(id, 42)
    }
}

private struct User: Identifiable, Sendable, Hashable, Codable {
    let id: ID
    var name: String

    struct ID: IntegerIDProtocol {
        let rawValue: Int
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

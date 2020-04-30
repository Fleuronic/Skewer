// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
@testable import Skewer

final class DecodingTests: XCTestCase {
	var decoder: JSONDecoder!
}

// MARK: -
extension DecodingTests {
	static var allTests = [
		("testSingleComponent", testSingleComponent),
		("testMultipleComponents", testMultipleComponents)
	]

	func testSingleComponent() {
		struct City: Decodable {
			let name: String
		}

		let name = "Cupertino"
		let json = ["name": name]
		let data = try! Data(json: json)
		let city = try! decoder.decode(City.self, from: data)

		XCTAssertEqual(city.name, name)
	}

	func testMultipleComponents() {
		struct App: Decodable {
			let downloadCount: Int
		}

		let downloadCount = 999
		let json = ["download-count": downloadCount]
		let data = try! Data(json: json)
		let app = try! decoder.decode(App.self, from: data)

		XCTAssertEqual(app.downloadCount, downloadCount)
	}

	// MARK: XCTestCase
	override func setUp() {
		decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromKebabCase
	}
}

// MARK: -
private extension Data {
	init(json: [String: Any]) throws {
		self = try JSONSerialization.data(withJSONObject: json, options: [])
	}
}

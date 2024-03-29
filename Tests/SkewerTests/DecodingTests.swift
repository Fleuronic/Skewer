// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Skewer

final class DecodingTests: XCTestCase {
	func testSingleComponent() {
		struct City: Decodable {
			let name: String
		}

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromKebabCase

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

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromKebabCase

		let downloadCount = 999
		let json = ["download-count": downloadCount]
		let data = try! Data(json: json)
		let app = try! decoder.decode(App.self, from: data)

		XCTAssertEqual(app.downloadCount, downloadCount)
	}

	func testSeparator() {
		struct App: Decodable {
			let downloadCount: Int
		}

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromCase(separatedBy: ".")

		let downloadCount = 999
		let json = ["download.count": downloadCount]
		let data = try! Data(json: json)
		let app = try! decoder.decode(App.self, from: data)

		XCTAssertEqual(app.downloadCount, downloadCount)
	}

	func testConversion() {
		struct City: Decodable {
			let name: String
		}

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convert { $0.lowercased() }

		let name = "Cupertino"
		let json = ["NAME": name]
		let data = try! Data(json: json)
		let city = try! decoder.decode(City.self, from: data)

		XCTAssertEqual(city.name, name)
	}
}

// MARK: -
private extension Data {
	init(json: [String: Any]) throws {
		self = try JSONSerialization.data(withJSONObject: json, options: [])
	}
}

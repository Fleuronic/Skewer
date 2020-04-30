// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
@testable import Skewer

final class EncodingTests: XCTestCase {
	var encoder: JSONEncoder!
}

// MARK: -
extension EncodingTests {
	static var allTests = [
		("testSingleComponent", testSingleComponent),
		("testAllLowercaseComponents", testAllLowercaseComponents),
		("testContainsUppercaseComponent", testContainsUppercaseComponent)
	]

	func testSingleComponent() {
		struct Person: Encodable {
			let name: String
		}

		let person = Person(name: "Tim Cook")
		let data = try! encoder.encode(person)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "name")
	}

	func testAllLowercaseComponents() {
		struct Company: Encodable {
			let originalIncorporationName: String
		}

		let company = Company(originalIncorporationName: "Apple Computer, Inc.")
		let data = try! encoder.encode(company)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "original-incorporation-name")
	}

	func testContainsUppercaseComponent() {
		struct Website: Encodable {
			let homepageURLString = "http://www.apple.com"
		}

		let saying = Website()
		let data = try! encoder.encode(saying)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "homepage-url-string")
	}

	// MARK: XCTestCase
	override func setUp() {
		encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToKebabCase
	}
}

// MARK: -
private extension Data {
	var firstEncodedJSONKey: String? {
		let json = try! JSONSerialization.jsonObject(with: self, options: []) as! [String: Any]
		return json.keys.first
	}
}

// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
@testable import Skewer

final class EncodingTests: XCTestCase {}

// MARK: -
extension EncodingTests {
	static var allTests = [
		("testSingleComponent", testSingleComponent),
		("testCapitalizedComponents", testCapitalizedComponents),
		("testLowercasedComponents", testLowercasedComponents)
	]

	func testSingleComponent() {
		struct Person: Encodable {
			let name: String
		}

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToKebabCase()

		let person = Person(name: "Tim Cook")
		let data = try! encoder.encode(person)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "name")
	}

	func testCapitalizedComponents() {
		struct Company: Encodable {
			let originalIncorporationName: String
		}

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToKebabCase(componentTransform: .capitalize)

		let company = Company(originalIncorporationName: "Apple Computer, Inc.")
		let data = try! encoder.encode(company)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "Original-Incorporation-Name")
	}

	func testLowercasedComponents() {
		struct Company: Encodable {
			let originalIncorporationName: String
		}

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToKebabCase(componentTransform: .lowercase)

		let company = Company(originalIncorporationName: "Apple Computer, Inc.")
		let data = try! encoder.encode(company)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "original-incorporation-name")
	}
}

// MARK: -
private extension Data {
	var firstEncodedJSONKey: String? {
		let json = try! JSONSerialization.jsonObject(with: self, options: []) as! [String: Any]
		return json.keys.first
	}
}

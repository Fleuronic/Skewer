// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Skewer

final class EncodingTests: XCTestCase {
	func testSingleComponent() {
		struct Person: Encodable {
			let name: String
		}

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToKebabCase(componentTransform: .lowercase)

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
		encoder.keyEncodingStrategy = .convertToKebabCase(componentTransform: .capitalize())

		let company = Company(originalIncorporationName: "Apple Computer, Inc.")
		let data = try! encoder.encode(company)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "Original-Incorporation-Name")
	}

	func testCapitalizedPrefixedComponents() {
		struct Company: Encodable {
			let originalIncorporationName: String
		}

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToKebabCase(componentTransform: .capitalize(prefix: "X"))

		let company = Company(originalIncorporationName: "Apple Computer, Inc.")
		let data = try! encoder.encode(company)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "X-Original-Incorporation-Name")
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

	func testSeparotor() {
		struct Company: Encodable {
			let originalIncorporationName: String
		}

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertedToSeparatedCase(with: ".")

		let company = Company(originalIncorporationName: "Apple Computer, Inc.")
		let data = try! encoder.encode(company)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "original.incorporation.name")
	}

	func testConversion() {
		struct Company: Encodable {
			let name: String
		}

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convert { $0.uppercased() }

		let company = Company(name: "Apple")
		let data = try! encoder.encode(company)
		let convertedKey = data.firstEncodedJSONKey!

		XCTAssertEqual(convertedKey, "NAME")
	}
}

// MARK: -
private extension Data {
	var firstEncodedJSONKey: String? {
		let json = try! JSONSerialization.jsonObject(with: self, options: []) as! [String: Any]
		return json.keys.first
	}
}

// Copyright © Fleuronic LLC. All rights reserved.

struct AnyKey {
	let stringValue: String
	let intValue: Int?
}

// MARK: -
extension AnyKey: CodingKey {
	// MARK: CodingKey
	init?(stringValue: String) {
		self.stringValue = stringValue
		intValue = nil
	}

	init?(intValue: Int) {
		stringValue = String(intValue)
		self.intValue = intValue
	}
}

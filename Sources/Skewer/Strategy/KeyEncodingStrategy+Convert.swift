// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONEncoder.KeyEncodingStrategy {
	static func convert(using conversion: @escaping (String) -> String) -> Self {
		.custom { keys in
			let stringValue = keys.last!.stringValue
			let convertedStringValue = conversion(stringValue)
			return AnyKey(stringValue: convertedStringValue)!
		}
	}
}

// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONDecoder.KeyDecodingStrategy {
	static var convertFromKebabCase: Self {
		convertFromCase(separatedBy: .hyphen)
	}

	static func convertFromCase(separatedBy separator: Character) -> Self {
		convert {
			$0.convertedFromCase(separatedBy: separator)
		}
	}
	
	static func convert(using conversion: @escaping (String) -> String) -> Self {
		.custom { keys in
			let stringValue = keys.last!.stringValue
			let convertedStringValue = conversion(stringValue)
			return AnyKey(stringValue: convertedStringValue)!
		}
	}
}

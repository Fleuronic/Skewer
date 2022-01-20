// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONDecoder.KeyDecodingStrategy {
	static var convertFromKebabCase: Self {
		convertedFromSeparatedCase(with: .hyphen)
	}

	static func convertedFromSeparatedCase(with separator: Character) -> Self {
		convert {
			$0.convertedFromSeparatedCase(with: separator)
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

// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONEncoder.KeyEncodingStrategy {
	static func convertToKebabCase(using componentTransform: ComponentTransform = .lowercase) -> Self {
		convertToCase(separatedBy: .hyphen, using: componentTransform)
	}

	static func convertToCase(separatedBy separator: String, using componentTransform: ComponentTransform = .lowercase) -> Self {
		convert {
			$0.convertedToCase(separatedBy: separator, using: componentTransform)
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

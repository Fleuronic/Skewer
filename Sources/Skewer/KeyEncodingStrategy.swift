// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONEncoder.KeyEncodingStrategy {
	static func convertToKebabCase(componentTransform: ComponentTransform = .lowercase) -> Self {
		convertedToSeparatedCase(with: .hyphen, componentTransform: componentTransform)
	}

	static func convertedToSeparatedCase(with separator: String, componentTransform: ComponentTransform = .lowercase) -> Self {
		convert {
			$0.convertedToSeparatedCase(with: separator, componentTransform: componentTransform)
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

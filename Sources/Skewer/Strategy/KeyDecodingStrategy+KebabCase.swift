// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONDecoder.KeyDecodingStrategy {
	static var convertFromKebabCase: Self {
		.custom { keys in
			let stringValue = keys.last!.stringValue
			let convertedStringValue = stringValue.convertedFromKebabCase
			return AnyKey(stringValue: convertedStringValue)!
		}
	}
}

// MARK: -
private extension String {
	var convertedFromKebabCase: Self {
		guard !isEmpty else { return self }

		let components = split(separator: .hyphen)
		if components.count == 1 {
			return self
		} else {
			let lowercasedStrings = [components[0].lowercased()]
			let capitalizedStrings = components[1...].map { $0.capitalized }
			return (lowercasedStrings + capitalizedStrings).joined()
		}
	}
}

// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONEncoder.KeyEncodingStrategy {
	static func convertToKebabCase(componentTransform: ComponentTransform = .lowercase) -> Self {
		.custom { keys in
			let stringValue = keys.last!.stringValue
			let convertedStringValue = stringValue.convertedToKebabCase(componentTransform: componentTransform)
			return AnyKey(stringValue: convertedStringValue)!
		}
	}
}

// MARK: -
private extension String {
	func convertedToKebabCase(componentTransform: JSONEncoder.KeyEncodingStrategy.ComponentTransform) -> Self {
		guard !isEmpty else { return self }

		var wordStart = startIndex
		var wordRanges: [Range<Index>] = []
		var searchRange = index(after: wordStart)..<endIndex

		while let uppercaseRange = rangeOfCharacter(from: .uppercaseLetters, range: searchRange) {
			wordRanges.append(wordStart..<uppercaseRange.lowerBound)
			searchRange = uppercaseRange.lowerBound..<searchRange.upperBound

			guard let lowercaseRange = rangeOfCharacter(from: .lowercaseLetters, range: searchRange) else {
				wordStart = searchRange.lowerBound
				break
			}

			let nextCharacterAfterCapital = index(after: uppercaseRange.lowerBound)
			searchRange = lowercaseRange.upperBound..<searchRange.upperBound

			if lowercaseRange.lowerBound == nextCharacterAfterCapital {
				wordStart = uppercaseRange.lowerBound
			} else {
				let beforeLowerIndex = index(before: lowercaseRange.lowerBound)
				wordRanges.append(uppercaseRange.lowerBound..<beforeLowerIndex)
				wordStart = beforeLowerIndex
			}
		}
		wordRanges.append(wordStart..<searchRange.upperBound)

		return wordRanges
			.map { self[$0] }
			.map { $0.applying(componentTransform) }
			.joined(separator: .hyphen)
	}
}

private extension Substring {
	func applying(_ componentTransform: JSONEncoder.KeyEncodingStrategy.ComponentTransform) -> String {
		switch componentTransform {
		case .capitalize:
			return capitalized
		case .lowercase:
			return lowercased()
		}
	}
}

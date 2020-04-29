// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONEncoder.KeyEncodingStrategy {
	static var convertToKebabCase: Self {
		.custom { keys in
			let stringValue = keys.last!.stringValue
			let convertedStringValue = stringValue.convertedToKebabCase
			return AnyKey(stringValue: convertedStringValue)!
		}
	}
}

// MARK: -
private extension String {
	var convertedToKebabCase: Self {
		guard !isEmpty else { return self }

		var wordStart = startIndex
		var wordRanges: [Range<Index>] = []
		var searchRange = index(after: wordStart) ..< endIndex

		while let uppercaseRange = rangeOfCharacter(from: .uppercaseLetters, range: searchRange) {
			wordRanges.append(wordStart ..< uppercaseRange.lowerBound)
			searchRange = uppercaseRange.lowerBound ..< searchRange.upperBound

			guard let lowercaseRange = rangeOfCharacter(from: .lowercaseLetters, range: searchRange) else {
				wordStart = searchRange.lowerBound
				break
			}

			let nextCharacterAfterCapital = index(after: uppercaseRange.lowerBound)
			searchRange = lowercaseRange.upperBound ..< searchRange.upperBound

			if lowercaseRange.lowerBound == nextCharacterAfterCapital {
				wordStart = uppercaseRange.lowerBound
			} else {
				let beforeLowerIndex = index(before: lowercaseRange.lowerBound)
				wordRanges.append(uppercaseRange.lowerBound ..< beforeLowerIndex)
				wordStart = beforeLowerIndex
			}
		}
		wordRanges.append(wordStart ..< searchRange.upperBound)

		let words = wordRanges.map { self[$0] }
		let lowercaseWords = words.map { $0.lowercased() }
		let result = lowercaseWords.joined(separator: .hyphen)

		return result
	}
}

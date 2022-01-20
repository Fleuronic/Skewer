// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

extension String {
	func convertedToSeparatedCase(with separator: String, componentTransform: JSONEncoder.KeyEncodingStrategy.ComponentTransform) -> Self {
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

		var components = wordRanges
			.map { self[$0] }
			.map { $0.applying(componentTransform) }

		if let prefix = componentTransform.prefix {
			components = [prefix] + components
		}

		return components.joined(separator: separator)
	}

	func convertedFromSeparatedCase(with separator: Character) -> Self {
		guard !isEmpty else { return self }

		let components = split(separator: separator)
		if components.count == 1 {
			return self
		} else {
			let lowercasedStrings = [components[0].lowercased()]
			let capitalizedStrings = components[1...].map { $0.capitalized }
			return (lowercasedStrings + capitalizedStrings).joined()
		}
	}
}

// MARK: -
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

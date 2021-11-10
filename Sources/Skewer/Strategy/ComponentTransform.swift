// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONEncoder.KeyEncodingStrategy {
	enum ComponentTransform {
		case capitalize(prefix: Bool)
		case lowercase
	}
}

// MARK: -
extension JSONEncoder.KeyEncodingStrategy.ComponentTransform {
	var hasPrefix: Bool {
		switch self {
		case .capitalize(let prefix):
			return prefix
		case .lowercase:
			return false
		}
	}
}

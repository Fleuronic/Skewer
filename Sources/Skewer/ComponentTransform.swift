// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONEncoder.KeyEncodingStrategy {
	enum ComponentTransform {
		case capitalize(prefix: String? = nil)
		case lowercase
	}
}

// MARK: -
extension JSONEncoder.KeyEncodingStrategy.ComponentTransform {
	var prefix: String? {
		switch self {
		case .capitalize(let prefix):
			return prefix
		case .lowercase:
			return nil
		}
	}
}

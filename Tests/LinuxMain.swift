// Copyright © Fleuronic LLC. All rights reserved.

@testable import SkewerTests
import XCTest

XCTMain(
	[
		testCase(EncodingTests.allTests),
		testCase(DecodingTests.allTests)
	]
)

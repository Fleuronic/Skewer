@testable import SkewerTests
import XCTest

XCTMain(
	[
		testCase(EncodingTests.allTests),
		testCase(DecodingTests.allTests)
	]
)

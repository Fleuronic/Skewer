// swift-tools-version:5.3

import PackageDescription

var targets: [Target] = [.target(name: "Skewer")]

#if swift(>=5.4)
targets.append(
	.testTarget(
		name: "SkewerTests",
		dependencies: ["Skewer"]
	)
)
#endif

let package = Package(
	name: "Skewer",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.watchOS(.v6),
		.tvOS(.v13)
	],
	products: [
		.library(
			name: "Skewer",
			targets: ["Skewer"]
		)
	],
	targets: targets
)

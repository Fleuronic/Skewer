// swift-tools-version:5.1
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

#if swift(>=5.5)
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
	targets: [
		.target(
			name: "Skewer",
			dependencies: []
		),
		.testTarget(
			name: "SkewerTests",
			dependencies: ["Skewer"]
		)
	]
)
#else
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
	targets: [
		.target(
			name: "Skewer",
			dependencies: []
		)
	]
)
#endif

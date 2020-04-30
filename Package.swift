// swift-tools-version:5.2
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Skewer",
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

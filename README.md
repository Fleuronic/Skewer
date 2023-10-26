# Skewer 🍡

<div align="center">

[![Release](https://img.shields.io/github/v/release/Fleuronic/Skewer?cache-seconds=0)](https://github.com/Fleuronic/Skewer/releases/latest)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/Fleuronic/Skewer/main/LICENSE)
[![Issues](https://img.shields.io/github/issues/Fleuronic/Skewer?logo=github&cache-seconds=0)](https://github.com/Fleuronic/Skewer/issues)
[![Downloads](https://img.shields.io/github/downloads/Fleuronic/Skewer/total?cache-seconds=0)](https://github.com/Fleuronic/Skewer/releases)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFleuronic%2FSkewer%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Fleuronic/Skewer)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFleuronic%2FSkewer%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Fleuronic/Skewer)
	
</div>

Provides support for "kebab-case" formatted (as opposed to just "snake_case" formatted) coding keys for `JSONEncoder` and `JSONDecoder`.

## Encoding

```swift
struct Website: Encodable {
    let homepageURLString: String
}

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToKebabCase

let website = Website(homepageURLString: "http://www.apple.com")
let data = try! encoder.encode(website)
let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
let convertedKey = json.keys.first!
// homepage-url-string
```

## Decoding

```swift
struct App: Decodable {
    let downloadCount: Int
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromKebabCase

let json = ["download-count": 999]
let data = try! JSONSerialization.data(withJSONObject: json, options: [])
let app = try! decoder.decode(App.self, from: data)
let downloadCount = app.downloadCount
// 999
```

## Installation
**Using the Swift Package Manager**

Add Skewer as a dependency to your `Package.swift` file. For more information, see the [Swift Package Manager documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

```swift
.package(url: "https://github.com/Fleuronic/Skewer", from: "3.0.0")
```

## License

Skewer is available under the MIT license. See the LICENSE file for more info.

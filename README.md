# Skewer 🍡

Provides support for "kebab-case" formatted (as opposed to just "snake_case" formatted) coding keys for `JSONEncoder` and `JSONDecoder`.

## Encoding

```swift
struct Website: Encodable {
    let homepageURLString = "http://www.apple.com"
}

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToKebabCase

let website = Website()
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

## License

Skewer is available under the MIT license. See the LICENSE file for more info.

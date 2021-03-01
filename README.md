# SwiftRegex

`SwiftRegex` is a simple wrapper around `NSRegularExpression` to simplify the usage of regular expression in Swift.

## Installation

Installation can be done via Swift Package Manager or by dragging Sources/SwiftRegex into your project.

```swift
dependencies: [
    .package(url: "https://github.com/flowbe/SwiftRegex.git", .upToNextMajor(from: "1.0.0"))
]
```

## Example usage

```swift
if let regex = Regex(pattern: #"\b(a|b)(c|d)\b"#, options: .caseInsensitive) {
    print(regex.numberOfMatches(in: "Ad eternam")) // Prints 1
} else {
    // The regular expression pattern is invalid.
}
```

The wrapper contains almost the same methods as `NSRegularExpression` but you don't need to manipulate inconvenient `NSRange` or `NSTextCheckingResult`. It also adds a `split` method.

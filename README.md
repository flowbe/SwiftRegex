# SwiftRegex

`SwiftRegex` is a simple wrapper around `NSRegularExpression` to simplify the usage of regular expression in Swift.

## Installation

Just drop the `Regex.swift` into your Xcode project, that's it!

## Example usage

```swift
if let regex = Regex(pattern: #"\b(a|b)(c|d)\b"#, options: .caseInsensitive) {
    print(regex.numberOfMatches(in: "Ad eternam")) // Prints 1
} else {
    // The regular expression pattern is invalid.
}
```

The wrapper contains almost the same methods as `NSRegularExpression` but you don't need to manipulate inconvenient `NSRange` or `NSTextCheckingResult`. It also adds a `split` method.

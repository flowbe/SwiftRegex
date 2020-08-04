//
//  Regex.swift
//  Force T
//
//  Created by Florentin BEKIER on 03/08/2020.
//  Copyright © 2020 Force T. All rights reserved.
//

import Foundation

/**
 A representation of a compiled regular expression that you apply to Unicode strings. This is a simple wrapper around `NSRegularExpression` for Swift.
 
 # Example usage
 
 ```
 if let regex = Regex(pattern: #"\b(a|b)(c|d)\b"#, options: .caseInsensitive) {
    print(regex.numberOfMatches(in: "Ad eternam")) // Prints 1
 } else {
    // The regular expression pattern is invalid.
 }
 ```
 */
struct Regex {
    private let regex: NSRegularExpression

    /**
     Returns an initialized `Regex` instance with the specified regular expression pattern and options.
     - Parameters:
        - pattern: The regular expression pattern to compile.
        - options: The regular expression options that are applied to the expression during matching.
     - Returns: An instance of `Regex` for the specified regular expression and options. If the regular expression pattern is invalid, the value may be `nil`.
     */
    init?(pattern: String, options: NSRegularExpression.Options = []) {
        if let regex = try? NSRegularExpression(pattern: pattern, options: options) {
            self.regex = regex
        } else {
            return nil
        }
    }

    /**
     Returns the number of matches of the regular expression within the specified range of the string.
     - Parameters:
        - string: The string to search.
        - options: The matching options to use.
     - Returns: The number of matches of the regular expression.
     */
    func numberOfMatches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> Int {
        return numberOfMatches(in: string, options: options, range: string.startIndex..<string.endIndex)
    }

    /**
    Returns the number of matches of the regular expression within the specified range of the string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
       - range: The range of the string to search.
    - Returns: The number of matches of the regular expression.
    */
    func numberOfMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>) -> Int {
        return regex.numberOfMatches(in: string, options: options, range: NSRange(range, in: string))
    }

    /**
    Returns an array containing all the matches of the regular expression in the string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
    - Returns: An array of array of matched strings.
    */
    func matches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [[String]] {
        return matches(in: string, options: options, range: string.startIndex..<string.endIndex)
    }

    /**
    Returns an array containing all the matches of the regular expression in the string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
       - range: The range of the string to search.
    - Returns: An array of array of matches strings.
    */
    func matches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>) -> [[String]] {
        return regex.matches(in: string, options: options, range: NSRange(range, in: string)).map { match in
            var matches = [String]()

            for i in 0..<match.numberOfRanges {
                if let range = Range(match.range(at: i), in: string) {
                    matches.append(String(string[range]))
                }
            }

            return matches
        }
    }

    /**
    Returns the first match of the regular expression within the specified range of the string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
    - Returns: An array of matched strings. The first string contains the text that matches the full pattern, and the next ones contain the text matching the capturing groups.
    */
    func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [String] {
        return firstMatch(in: string, options: options, range: string.startIndex..<string.endIndex)
    }

    /**
    Returns the first match of the regular expression within the specified range of the string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
       - range: The range of the string to search.
    - Returns: An array of matched strings. The first string contains the text that matches the full pattern, and the next ones contain the text matching the capturing groups.
    */
    func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>) -> [String] {
        var matches = [String]()

        if let match = regex.firstMatch(in: string, options: options, range: NSRange(range, in: string)) {
            for i in 0..<match.numberOfRanges {
                if let range = Range(match.range(at: i), in: string) {
                    matches.append(String(string[range]))
                }
            }
        }

        return matches
    }

    /**
    Returns the range of the first match of the regular expression within the specified range of the string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
    - Returns: The range of the first match.
    */
    func rangeOfFirstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> Range<String.Index>? {
        return rangeOfFirstMatch(in: string, options: options, range: string.startIndex..<string.endIndex)
    }

    /**
    Returns the range of the first match of the regular expression within the specified range of the string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
       - range: The range of the string to search.
    - Returns: The range of the first match.
    */
    func rangeOfFirstMatch(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>) -> Range<String.Index>? {
        let nsrange = regex.rangeOfFirstMatch(in: string, options: options, range: NSRange(range, in: string))
        return Range(nsrange, in: string)
    }

    /**
    Returns a new string containing matching regular expressions replaced with the template string.
    - Parameters:
       - string: The string to search.
       - options: The matching options to use.
       - replacement: The string used when replacing matching instances.
    - Returns: A string with matching regular expressions replaced by the replacement string.
    */
    func replaceMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], with replacement: String) -> String {
        return replaceMatches(in: string, options: options, range: string.startIndex..<string.endIndex, with: replacement)
    }

    /**
    Returns a new string containing matching regular expressions replaced with the template string.
    - Parameters:
       - string: The string to search for values within.
       - options: The matching options to use.
       - range: The range of the string to search.
       - replacement: The string used when replacing matching instances.
    - Returns: A string with matching regular expressions replaced by the replacement string.
    */
    func replaceMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: Range<String.Index>, with replacement: String) -> String {
        return regex.stringByReplacingMatches(in: string, options: options, range: NSRange(range, in: string), withTemplate: replacement)
    }

    /**
     Returns an array containing the string split by the matched regular expression.
     - Parameter string: The string to split.
     - Returns: An array of substrings.
     */
    func split(_ string: String) -> [String] {
        let nsrange = NSRange(string.startIndex..<string.endIndex, in: string)
        let matchingRanges = regex.matches(in: string, range: nsrange).compactMap { match in
            return Range(match.range, in: string)
        }

        var pieceRanges = [string.startIndex..<(matchingRanges.first?.lowerBound ?? string.endIndex)]

        for i in 0..<matchingRanges.count {
            let isLast = i + 1 == matchingRanges.count

            let lowerBound = matchingRanges[i].lowerBound
            let upperBound = matchingRanges[i].upperBound
            let start = string.index(lowerBound, offsetBy: string.distance(from: lowerBound, to: upperBound))
            let end = isLast ? string.endIndex : matchingRanges[i + 1].lowerBound

            pieceRanges.append(start..<end)
        }

        return pieceRanges.map { String(string[$0]) }
    }
}

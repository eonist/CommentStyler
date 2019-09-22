import Foundation
/**
 * Flag (Pattern) Description:
 * i - If set, matching will take place in a case-insensitive manner.
 * x - If set, allow use of white space and #comments within patterns
 * s - If set, a "." in a pattern will match a line terminator in the input text. By default, it will not. Note that a carriage-return / line-feed pair in text behave as a single line terminator, and will match a single "." in a regular expression pattern
 * m - Control the behavior of "^" and "$" in a pattern. By default these will only match at the start and end, respectively, of the input text. If this flag is set, "^" and "$" will also match at the start and end of each line within the input text.
 * - Para Controls the behavior of \b in a pattern. If set, word boundaries are found according to the definitions of word found in Unicode UAX 29, Text Boundaries. By default, word boundaries are identified by means of a simple classification of characters as either “word” or “non-word”, which approximates traditional regular expression behavior. The results obtained with the two options can be quite different in runs of spaces and other non-word characters.
 */
public class RegExp {
   /**
    * - Note: NSRegularExpression. (has overview of the regexp syntax supported) https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSRegularExpression_Class/index.html
    * - Note: NSRegularExpressionOptions: DotMatchesLineSeparators,CaseInsensitive,AnchorsMatchLines
    * ## Examples:
    * RegExp.match("My name is Taylor Swift","My name is (.*)")//Swift
    * RegExp.match("hello world","(\\b\\w+\\b)")//hello, world
    * RegExpParser.match("abc 123 abc 123 abc 123 xyz", "[a-zA-Z]{3}")//["abc", "abc", "abc", "xyz"]
    * - Fixme: ⚠️️ Probably return optional array?
    * - Fixme: Then if it is outof bound return eigther an empty array or nil
    * - Fixme: Then only do substringwithrange if NSRange is not NSOutOfBoundRange type
    */
   public static func match(_ text: String, pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> [String] {
      return matches(text, pattern: pattern).map { (text as NSString).substring(with: $0.range) }
   }
   /**
    * loops over every string-segment that match the pattern
    * - Note: Similar to Exec in other languages
    * - Note: NSRegExp uses the ICU regexp syntax: http://userguide.icu-project.org/strings/regexp
    * - Note: Use this method when doing named capturing group or location of matches
    * - Note: use this call to get the capturing group: (str as NSString).substringWithRange(match.rangeAtIndex(1))  capturing groups from index (1 - n)
    * - Note: use an "enum" if you need named capturing groups. like: enum FolderTaskParts:Int{ case folder = 1, content }
    * - Note: its also possible to find number of matches this way: regex.numberOfMatchesInString(text options:[] NSMakeRange(0, nsString.length))
    * - Fixme: ⚠️️ Figure out how to do numbered capturing groups ($n - n is a digit. Back referencing to a capture group. n must be >= 0 and not greater than ) maybe with \$2 \$3 etc?
    * - Fixme: Research how to deal with swift unicode chars, emojis etc: see this: http://stackoverflow.com/questions/25882503/how-can-i-use-nsregularexpression-on-swift-strings-with-variable-width-unicode-c
    * ## Examples:
    * let str = "blue:0000FF green:00FF00 red:FF0000"
    * RegExp.matches(str, "(\\w+?)\\:([A-Z0-9]+?)(?: |$)").forEach {
    *     Swift.print("match.numberOfRanges: " + "\($0.numberOfRanges)")/*The first item is the entire match*/
    *     let content = (str as NSString).substringWithRange($0.rangeAtIndex(0))/*the entire match*/
    *     let name = $0.value(str, 1)/*capturing group 1*/
    *     let value = $0.value(str, 2)/*capturing group 2*/
    * } // Outputs: name: green, value: 00FF00...and so on
    */
   public static func matches(_ text: String!, pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> [NSTextCheckingResult] {
      do {
         let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: options)
         let nsString: NSString = text as NSString
         let results: [NSTextCheckingResult] = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length)) // fixme: ⚠️️ use something else than NSMakeRange
         return results
      } catch let error as NSError {
         print("invalid regex: \(error.localizedDescription)")
         return [] // - Fixme: ⚠️️ return nil here
      }
   }
   /**
    * - Fixme: ⚠️️ Maybe add generics to the matcher closure somehow?
    * ## Examples:
    * let str = "blue:0000FF green:00FF00 red:FF0000"
    * let pattern = "(\\w+?)\\:([A-Z0-9]+?)(?: |$)"
    * let matches: [String] = str.matches(pattern: pattern) { $0.value(str, key: 2) } // 0000FF, 00FF00, FF0000
    * let ranges: [Range<String.Index>] = str.matches(pattern) { $0.stringRange(string, key: 2) } // (4,16), (19,21), (23,30) etc
    */
   public static func matches<T>(str: String, pattern: String, options: NSRegularExpression.Options = .caseInsensitive, matcher: (_ result: NSTextCheckingResult) -> T) -> [T] {
      return RegExp.matches(str, pattern: pattern).map { matcher($0) }
   }
}

//func runThis<T>(first:T, _ closure: (T) -> T)->T {
//   return closure(first)
//}
//
//func someMethod<T>(someVar:T)->T {
//   return someVar
//}
//
//runThis("works",someMethod)//works

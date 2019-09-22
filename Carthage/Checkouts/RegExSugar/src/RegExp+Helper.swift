import Foundation
/**
 * Helper
 */
extension RegExp {
   /*
    * Extracts associated capture groups from the RegExp.matches result
    * - Note: since apples regex implementation doesn't support name capture groups, we have to use indecies, and then we can store these indicies in an enum with more descriptive names
    * - Note: used by NSTextCheckingResult.value(str: String, key: Int)
    * ## Examles:
    * RegExp.value(fullString, match, StatusParts.second.rawValue)
    * - Fixme: ⚠️️ You should check if there is content in the range first, if ther eis not return nilor error
    * - Fixme: ⚠️️ Would be great if .rawValue was done inside this method, can be done with <T> possibly look at the apple docs about enumerations
    */
   public static func value(_ str: String, result: NSTextCheckingResult, key: Int) -> String {
      let range = result.range(at: key)
      return (str as NSString).substring(with: range)
   }
   /**
    * Finds first index of pattern in string
    */
   public static func search(_ input: String, pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> Int? {
      guard let range = input.range(of: pattern, options: .regularExpression) else { return nil }
      return input.distance(from: input.startIndex, to: range.lowerBound)
   }
   /**
    * Converts NSRange -> Range<String.Index>
    */
   public static func stringRange(str: String, range: NSRange) -> Range<String.Index> { // (str.startIndex, offsetBy: range.location + range.length)
      let start: String.Index = str.index(str.startIndex, offsetBy: range.location, limitedBy: str.endIndex) ?? str.endIndex
      let end: String.Index = str.index(str.startIndex, offsetBy: range.location + range.length, limitedBy: str.endIndex) ?? str.endIndex
      return start..<end
   }
   /**
    * Converts NSRange -> String
    */
   public static func string(str: String, range: NSRange) -> String {
//      let stringRange: Range<String.Index> = RegExp.stringRange(str: str, range: range)
      let nsStr: NSString = str as NSString
      return nsStr.substring(with: range) as String
//      return .init(str[stringRange]) // Fixme: ⚠️️ Might want to assert if the range exists in the array?
   }
}
/**
 * NSTextCheckingResult
 */
extension NSTextCheckingResult {
   /**
    * value for key
    */
   public func value(_ str: String, key: Int) -> String { // Convenience
      return RegExp.value(str, result: self, key: key)
   }
   /**
    * stringRange for string and checkingResult
    */
   public func stringRange(_ str: String, key: Int) -> Range<String.Index> {
      let range: NSRange = self.range(at: key) // Capturing group
      return RegExp.stringRange(str: str, range: range)
   }
   /**
    * Returns range and string
    */
//   public func rangeAndString(_ str: String, key: Int) -> RegExp.MatcherResult {
//      let stringRange: Range<String.Index> = self.stringRange(str, key: key)
//      let match: String = .init(str[stringRange]) // Fixme: ⚠️️ Might want to assert if the range exists in the array?
//      return (range: stringRange, match: match)
//   }
   /**
    * Returns range and string
    * - Note: ⚠️️ We use NSRange because it works better with emojies in regex (Ref: google emoji regex swift)
    */
   public func nsRangeAndString(_ str: String, key: Int) -> RegExp.MatchResult {
      //let stringRange: Range<String.Index> = self.stringRange(str, key: key)
      let range = self.range(at: key)
      let match: String = RegExp.string(str: str, range: range)//.init(str[stringRange]) // Fixme: ⚠️️ Might want to assert if the range exists in the array?
      return (range: range, match: match)
   }
}

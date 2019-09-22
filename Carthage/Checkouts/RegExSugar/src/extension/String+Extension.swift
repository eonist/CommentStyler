import Foundation
/**
 * - Fixme: ⚠️️ Add examples to these methods
 */
extension String {
   public func test(_ pattern: String) -> Bool {
      return RegExp.test(self, pattern: pattern)
   }
   public func search(_ pattern: String) -> Int? {
      return RegExp.search(self, pattern: pattern)
   }
}
/**
 * Match
 */
extension String {
   public func match(_ pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive) -> [String] {
      return RegExp.match(self, pattern: pattern, options: options)
   }
   public func matches(_ pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive) -> [NSTextCheckingResult] {
      return RegExp.matches(self, pattern: pattern, options: options)
   }
   /**
    * Works better with capturing groups
    */
   public func matches<T>(pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive, matcher: (_ result: NSTextCheckingResult) -> T) -> [T] {
      return RegExp.matches(str: self, pattern: pattern, options: options, matcher: matcher)
   }
}
/**
 * Replace
 */
extension String {
   public func replace(_ pattern: String, _ replacement: String) -> String {
      return RegExp.replace(self, pattern: pattern, replacement: replacement)
   }
   public func replace(_ pattern: String, options: NSRegularExpression.Options = .caseInsensitive, replacer: RegExp.Replacer) -> String {
      return RegExp.replace(self, pattern: pattern, options: options, replacer: replacer)
   }
   /**
    * Works better with capturing groups
    */
   public func replace(pattern: String, options: NSRegularExpression.Options = .caseInsensitive, replace: RegExp.Replace) -> String {
      return RegExp.replace(str: self, pattern: pattern, options: options, replace: replace)
   }
}

import Foundation

extension String {
   public func match(_ pattern: String!, _ options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> [String] {
      return RegExp.match(self, pattern: pattern, options: options)
   }
   public func matches(_ pattern: String!, _ options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> [NSTextCheckingResult] {
      return RegExp.matches(self, pattern: pattern, options: options)
   }
   public func test(_ pattern: String) -> Bool {
      return RegExp.test(self, pattern: pattern)
   }
   public func replace(_ pattern: String, _ replacement: String) -> String {
      return RegExp.replace(self, pattern, replacement: replacement)
   }
   public func replace(_ pattern: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive, replacer: RegExp.Replacer) -> String {
      return RegExp.replace(self, pattern: pattern, options: options, replacer: replacer)
   }
   public func search(_ pattern: String) -> Int? {
      return RegExp.search(self, pattern: pattern)
   }
}

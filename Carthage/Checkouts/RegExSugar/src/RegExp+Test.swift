import Foundation

extension RegExp {
   /**
    * Asserts if a match exists
    * - Note: NSRegularExpression. https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSRegularExpression_Class/index.html
    * - Note: for simple implimentations:  str.rangeOfString(pattern, options: .RegularExpressionSearch) != nil
    * - ## Examples:
    * RegExp.test("hello world","o.*o")//true
    * - Caution: upgraded in swift 3, was-> str.rangeOfString(pattern, options: .RegularExpressionSearch) != nil
    */
   public static func test(_ str: String, pattern: String) -> Bool {
      return str.range(of: pattern, options: .regularExpression) != nil//or do something like this: return RegExpParser.match(pattern,options).count > 0
   }
}

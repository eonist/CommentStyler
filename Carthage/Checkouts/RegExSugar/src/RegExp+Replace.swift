import Foundation

extension RegExp {
   /**
    * Replaces all matches with the replacment string
    * - Returns Value A string with matching regular expressions replaced by the template string.
    * - Note: you can use this call replaceMatchesInString to modify the original string, must use nsmutablestring to do this
    * - Note: ⚠️️ NSRegularExpression has lots of good info -> https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSRegularExpression_Class/index.html
    * - Important: ⚠️️ by using "$1" or "$2" etc you can replace with the match
    * - Parameter string The string to search for values within.
    * - Parameter options: The matching options to use. See NSMatchingOptions for possible values.
    * - Parameter range: The range of the string to search.
    * - Parameter replacement: The substitution template used when replacing matching instances.
    * - Fixme: ⚠️️ The PARAM: text should be inout, maybe?
    * ## Examples:
    * RegExp.replace("<strong>Hell</strong>o, <strong>Hell</strong>o, <strong>Hell</strong>o", "<\\/?strong>",  "*")//Output:  "*Hell*o, *Hell*o, *Hell*o"
    * RegExp.replace("yeah yeah","(\\b\\w+\\b)", "bla")//bla bla
    */
   public static func replace(_ str: String, pattern: String, replacement: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> String {
      do {
         let stringlength: Int = str.count
         let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: options)
         let range: NSRange = NSMakeRange(0, stringlength)
         let modString: String = regex.stringByReplacingMatches(in: str, options: [], range: range, withTemplate: replacement)
         return modString
      } catch let error as NSError {
         print("invalid regex: \(error.localizedDescription)")
         return "" // fixme ⚠️️ return nil
      }
   }
   /**
    * Loops over every string-segment that match the pattern and replaces with a closure (uses String in the closure)
    * - Fixme: ⚠️️ Try to performance test if accumulative substring is faster (you += before the match + the match and so on)
    * - Parameter replacer: (String)
    * ## Examples:
    * let str: String = "bad wolf, bad dog, Bad sheep"
    * let pattern: String = "\\b([bB]ad)\\b"
    * let result: String = str.replace(pattern) { $0.isLowerCased ? $0 : $0.lowercased() } // converts all "Bad" words to lowercase
    * Swift.print(result) // bad wolf, bad dog, bad sheep
    */
   public static func replace(_ str: String, pattern: String, options: NSRegularExpression.Options = .caseInsensitive, replacer: Replacer) -> String {
      var str = str
      RegExp.matches(str, pattern: pattern).reversed().forEach { nsCheckingResult in
         let range: NSRange = nsCheckingResult.range(at: 1) // The first result is the entire match and 1 is the actual precice match, I think
         let stringRange: Range<String.Index> = RegExp.stringRange(str: str, range: range)
         let match: String = .init(str[stringRange]) // Fixme: ⚠️️ Might want to assert if the range exists in the array?
         guard let replacment: String = replacer(match) else { Swift.print("RegExp.replace() ⚠️️ something wrong ⚠️️ "); return }
         str.replaceSubrange(stringRange, with: replacment)
      }
      return str
   }
   /**
    * Loops over every string-segment that match the pattern and replaces with a closure (uses Range in the closure)
    * - Parameter replace: (Range)
    * ## Examples:
    * let string = "blue:0000FF green:00FF00 red:FF0000"
    * let ptrn: String = "(\\w+?)\\:([A-Z0-9]+?)(?: |$)"
    * let theResult: String = string.replace(pattern: ptrn) { result in
    *    let beginning = result.stringRange(string, key: 1) // Capturing group 1
    *    let newBegginingStr: String = { // Manipulate the string a bit
    *       let theStr: String = .init(string[beginning])
    *       return theStr.uppercased()
    *    }()
    *    let end = result.stringRange(string, key: 2) // Capturing group 2
    *    let newEndStr: String = .init(string[end]) // Keep the same string
    *    return [(beginning, newBegginingStr), (end, newEndStr)]
    * }
    * Swift.print("theResult:  \(theResult)") // BLUE:0000FF GREEN:00FF00 RED:FF0000
    * - Fixme: ⚠️️ You dont need the array to be optional, empty array works fine
    * - Fixme: this mthod uses reversed() twice, i guess it makes sense?
    */
   public static func replace(str: String, pattern: String, options: NSRegularExpression.Options = .caseInsensitive, replace: Replace) -> String {
      var str = str
      RegExp.matches(str, pattern: pattern).reversed().forEach { nsCheckingResult in
         guard let replacementResult: ReplacmentResult = replace(nsCheckingResult) else { Swift.print("RegExp.replace() ⚠️️ something wrong ⚠️️ "); return }
         replacementResult.reversed().forEach {
            let nsStr: NSString = str as NSString
//            nsStr.subr
            str = nsStr.replacingCharacters(in: $0.range, with: $0.replacement)
//            str.replaceSubrange($0.range, with: $0.replacement)
         }
      }
      return str
   }
}
/**
 * - fixme: ⚠️️ re implement strinrange with the code bellow
 */
//extension String {
//   func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
//      let from16 =  advance(utf16.startIndex, nsRange.location, utf16.endIndex)
//      let to16 =  advance(from16, nsRange.length, utf16.endIndex)
//      if let from = String.Index(from16, within: self),
//         let to = String.Index(to16, within: self) {
//         return from ..< to
//      }
//      return nil
//   }
//}
//The inverse conversion is
//extension String {
//   func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
//      let utf16view = self.utf16
//      let from = String.UTF16View.Index(range.startIndex, within: utf16view)
//      let to = String.UTF16View.Index(range.endIndex, within: utf16view)
//      return NSMakeRange(from - utf16view.startIndex, to - from)
//   }
//}

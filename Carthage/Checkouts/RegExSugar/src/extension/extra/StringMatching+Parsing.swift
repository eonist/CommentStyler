import Foundation

class StringMatching {}
/**
 * Parsing
 */
extension StringMatching {
   enum Pattern {
      static let digit: String = "^(\\-?\\d*?\\.?\\d*?)(px|$)"//\-?\d*?(\.?)((?1)\d+?(?=px)
      static let path: String = "^.*?\\/(?=\\w*?\\.\\w*?$)"
      static let fileName: String = "^.*?\\/(\\w*?\\.\\w*?$)"
      static let colorHex: String = "(?<=^#)(?:[a-fA-F0-9]{3}){1,2}|(?<!^#)(?:[a-fA-F0-9]{3}){1,2}$"
   }
   /**
    * Returns a file path, excluding the file name and file-suffix
    * - Parameter: input: usually formated like: /Users/James/Downloads/PanelView.png
    * - RETURN: a string formatted like: /Users/James/Downloads/
    * ## Examples:
    * path(Users/User/Desktop/main.css);//Users/User/Desktop/
    * - Note: you can also do this another way:
    * var match: Array = input.split(".");
    * var path: String = String(match[0]).substring(0, String(match[0]).lastIndexOf("/"));
    * - Note: ⚠️️ There is also a native way if you look through NSURL
    */
   public static func path(_ url: String) -> String {
      return url.match(Pattern.path)[0]
   }
   /**
    * - Note: There is also a native way if you look through NSURL
    */
   public static func fileName(_ url: String) -> String {
      return url.match(Pattern.fileName)[1]
   }
   /**
    * Returns the percentage as a CGFloat
    */
   public static func percentage(_ value: String) -> CGFloat? {
      let match = value.match(".*?(?=%)")
      guard let val: String = match.isEmpty ? nil : match[0], let value = Double(val) else { return nil }
      return CGFloat(value)
   }
   /**
    * Returns a digit as a Number or a String type (suffix are removed from the return value)
    * - RETURN: a Numberor a String type
    * - Parameter: string can be 10, 20px, -20px, 0.2px, -.2, 20%, 0.2
    * - Note: if the digit has a trailing % character it is returned as a String
    * - Fixme: ⚠️️ This could probably be simpler if you just added a none capturing group and used regexp.match
    */
   public static func digit(_ string: String) -> CGFloat? {
      let matches = RegExp.matches(string, pattern: Pattern.digit)
      let match: NSTextCheckingResult = matches[0]
      let value: String = RegExp.value(string, result: match, key: 1)
      guard let val = Double(value) else { return nil }
      return CGFloat(val)
   }
   /**
    * - Note: Supports 5 hex color formats: #FF0000,0xFF0000, FF0000, F00,(red,purple,pink and other web colors)
    * Returns an rgb value
    * - Fixme: //green, blue, orange etc// :Fixme: support for all of w3c color types
    * - Fixme: move this to a method named webColor?
    */
   //   static func color(_ hexColor: String) -> UInt{
   //      if hexColor.test(Pattern.colorHex) {/*asserts if the color is in the correct hex format*/
   //         //⚠️️⚠️️⚠️️⚠️️ Fixme: use native firstMatch instead of the bellow line, its way faster⚠️️⚠️️⚠️️⚠️️
   //         var hex: String = RegExp.match(hexColor, pattern: Pattern.colorHex)[0]
   //         if hex.count == 3 {
   //            hex = String(hex.first!, hex.first!, hex[hex.index(hex.startIndex, offsetBy: 1)], hex[hex.index(hex.startIndex, offsetBy: 1)], hex.last!, hex.last!])//upgraded to swift 3
   //         }/*Convert shorthand hex to hex*/
   //         return ("0x" + hex).uint
   //      } else {
   //         return ColorTypes.color(hexColor)
   //      }
   //   }
   /**
    * Returns NSColor for variouse literal color formats
    */
   //   static func nsColor(_ hexColor: String) -> NSColor{
   //      return StringParser.color(hexColor).color
   //   }
}

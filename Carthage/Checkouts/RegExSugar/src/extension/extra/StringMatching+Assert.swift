import Foundation
/**
 * Assert
 */
extension StringMatching {
   enum AssertPattern {
      static let digit: String = "^-?\\d*?\\.?\\d*?(px)?$"
      static let metric: String = "^-?\\d*?\\.?\\d*?(ems|%)?$"
      static let color: String = "^#?([a-fA-F0-9]{3}){1,2}$"
   }
   /**
    * Asserts if a string is a digit (10, 20px, -20px, 0.2px, -.2, 0.2)
    */
   public static func isDigit(_ string: String) -> Bool {
      return string.test(AssertPattern.digit)
   }
   /**
    * 2ems,20% etc
    */
   public static func isMetric(_ string: String) -> Bool {
      return string.test(AssertPattern.metric)
   }
   public static func isColor(_ string: String) -> Bool {
      return string.test(AssertPattern.color)
   }
   /**
    * Asserts if PARAM: value is a percentage
    */
   public static func isPercentage(_ value: String) -> Bool {
      return value.test(".*?(?=%)")
   }
}

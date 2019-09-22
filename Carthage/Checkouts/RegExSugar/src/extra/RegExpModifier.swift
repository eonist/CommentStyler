import Foundation

public class RegExpModifier {
    /**
     * Returns a Comment free css string
     * - Parameter: input: a Css String such as "P{color:#00FF00;}"
     */
    public static func removeComments(_ input: String) -> String {
        return input.replace(Pattern.removeComments, "")
    }
    /**
     * Returns input with punctuation replaced by replacement
     */
    public static func replacePunctuation(_ input: String, replacement: String) -> String {
        return input.replace("[.]", replacement)
    }
    /**
     * Returns the input without whitespace on the left and right side
     * - Note: writing this function is not easy, check proto website for inspiration
     * - Note: StringModifier.trimWhiteSpace can also be used. could be faster
     * - Fixme: possible rewrite inspiration: test6.match(/(?<=<[tT][iI][tT][lL][eE]>).*(?=<\/[tT][iI][tT][lL][eE]>)/g))
     * - Caution: Does not work well with strings that are empty, this is a problem in the current regExp code
     */
    public static func removeWrappingWhitespace(_ input: String) -> String {
        // :Fixme: ⚠️️ the bellow is wrong , it can be (?<=^|\s)(-|\n)(?=$|\s)  // you dont need to test if there is multiple whitespaces just 1
        //⚠️️⚠️️⚠️️⚠️️ Fixme: use native firstMatch instead of the bellow line, its way faster⚠️️⚠️️⚠️️⚠️️
      return RegExp.match(input, pattern: Pattern.removeWrappingWhitespace)[0]
    }
    /**
     * Returns param input without the last whitespacecharcter
     * - Note: If the input has no whitespace at the end the input is returned as is
     */
    public static func removeEndingWhiteSpace(_ input: String) -> String {
        return input.replace("\\s*?$", "")
    }
    /**
     * Returns a @param input without dubble or more whitespace
     * - Parameter replacement: the single white space, can be zero whitespace aswell
     * ## Examples:
     * singularWhitespace("       A  C  B");//Output: " A C B"
     */
    public static func singularWhitespace(_ input: String, replacement: String = " ") -> String {
        return input.replace("\\s\\s*?(?=\\S|$)", replacement)
    }
    /**
     * Returns @param input without space characters on the left and right side of it self
     * - Note supports only single spaces.
     * - Note the space character in unicode: \040
     * ## Examples:
     * "test ", "   test" , "  test  " or "test"//test
     */
    public static func removeWrappingSpaces(input: String) -> String {
        return input.match("[^\040].*?(?=\040|$)")[0]
    }
    /**
     * Returns an html email link from @param input
     * - Parameter input: a string containing atleast 1 email
     * ## Examples:
     * emailLink("Hello, john@forta.com is my email address.");//Hello, <A HREF=mailto:john@forta.com>ben@forta.com</A> is my email address.
     */
    public static func emailLink(input: String) -> String {
        return input.replace(Pattern.emailLink, "<A HREF=mailto:$1>$1</A>")
    }
    /**
     * Returns the first instance of an email replaced with @param replacementEmail from @param input
     * ## Examples :
     * replaceEmail("The following was posted by user@domain.com.", "<email>@<domain>.com")//The following was posted by <email>@<domain>.com.
     */
    public static func replaceEmail(_ input: String, replacementEmail: String) -> String {
        return input.replace(Pattern.replaceEmail, replacementEmail)
    }
    /**
     * Returns the an obscured email of first instance of an email in the @param input
     * ## Examples:
     * obscureEmail("The following was posted by user@domain.com.")// The following was posted by user AT domain DOT com
     */
    public static func obscureEmail(input: String) -> String {
        let matches = input.matches(Pattern.obscureEmail)
        let obscuredEmail: String = matches.reduce("") {
         let match: String = $1.value(input, key: 1)
            return replacer(match)
        }
        func replacer(_ match: String) -> String {
            var string: String = match.replace("@", " AT ")
            string = string.replace("\\./g", " DOT ")
            return string
        }
        return obscuredEmail
    }
    /**
     * Returns a telephone number conformed to (313) 555-1234 from @param input
     * - Parameter input: a string containing atleast 1 telephone number formated like xxx-xxx-xxxx
     * ## Examples:
     * conformUsTeleNr(313-555-1234 248-555-9999 810-555-9000);//(313) 555-1234, (248) 555-9999, (810) 555-9000
     */
    public static func conformUsTeleNr(input: String) -> String {
        return input.replace("(\\d{3})(-)(\\d{3})(-)(\\d{4})", "($1) $3-$5")
    }
    /**
     * Returns words with single quotation marks from the @param input
     * - Parameter input: words with dubble quotationmarks
     * replaces all quotion (quotation mark followed by word followed by quotation mark) into curly quotes
     *
     */
    public static func singleQuotation(input: String) -> String {
        return input.replace("([^\"]*)", "\'$1\'")
    }
    /**
     * Returns @param input with the content between h1 tags, replaced by @param replacement
     * ## Example:
     * var text:String = "<BODY> "+
     *						"<H1>Welcome to my Homepage</H1>" +
     *						" Content is divided into two sections:<BR> " +
     * 						"<H2>ColdFusion</H2> " +
     *						"Information about Macromedia ColdFusion." +
     *						"<H2>Wireless</H2> " +
     *						"Information about Bluetooth, 802.11, and more. " +
     *						"<H2>This is not valid HTML</H3> " +
     *						"</BODY>"
     * replaceContentBetween(text,"WELCOME TO MY HOMEPAGE")
     */
    public static func replaceContentBetweenHTags(_ input: String, replacement: String) -> String {
        return input.replace("(<[Hh]1>)(.*?)(<\\/[Hh]1>)", replacement)
    }
}
/**
 * Patterns
 */
extension RegExpModifier {
   public enum Pattern {
      public static let removeComments = "\\/\\*.*?\\*\\/"
      public static let removeWrappingWhitespace = "[^\\s]+?(?<=\\b)(.|\\n)*?(?=$|\\s*?$)"
      public static let removeWrappingSpaces = "[^\040].*?(?=\040|$)"
      public static let replaceEmail = "((?:\\w|[_.\\-])+)@(?:((?:\\w|-)+)\\.)+\\w{2,4}+"
      public static let obscureEmail = "(?:\\w|[_.\\-])+@(?:(?:\\w|-)+\\.)+\\w{2,4}"
      public static let emailLink = "(\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+)"
   }
}

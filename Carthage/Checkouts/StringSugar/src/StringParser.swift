import Foundation

public class StringParser {
    /**
     * Returns encode text (escaped)
     * - Caution: ⚠️️ encode does not handle the double quote char very well
     * - NOTE: this could also be done by creating a a method that does all the character trickery involved in unescaping/escaping text, but this method leverages the php language to do all this for us
     * ## Examples:
     * encode("<image location:files/img/image.jpg")--%3Cimage+location%3Afiles%2Fimg%2Fimage.jpg
     * "testing this stuff.121".encode//testing%20this%20stuff.121
     */
    public static func encode(_ str: String) -> String? {
        return str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    /**
     * Returns dencode text (unescaped)
     * - NOTE: this could also be done by creating a method that does all the character trickery involved in unescaping/escaping text, but this method leverages the php language to do all this for us
     * - CAUTION: if your string has the % sign. Then a suggestion is to encode it first
     * ## Examples:
     * decode(%3Cimage+location%3Afiles%2Fimg%2Fimage.jpg)--<image location:files/img/image.jpg
     * "testing%20this%20stuff.121".decode//testing this stuff.121
     */
    public static func decode(_ str: String) -> String? {
        return str.removingPercentEncoding//swift 3 upgrade was -> stringByRemovingPercentEncoding
    }
    /**
     * Returns an array for every line in a string
     */
    public static func paragraphs(_ string: String) -> [String] {
        var result = split(string, "\n")
        result.removeLast()/*if the string is empty it still returns a result as [""] and if the string is not empty it returns plus one empty string. so we pop the last one of the array*/
        return result
    }
	/**
     * Returns an Array of words derived from PARAM str by splitting it at every PARAM delimiter
     * ## EXAMPLES: components("Berlin, Paris, New York, San Francisco")//Returns an array with the following values:  ["Berlin", " Paris", " New York", " San Francisco"]
	  * - NOTE: use "\n" to retrive paragraphs
     * - NOTE: The opposit of this method is StringModifier.combine(array," ")
     */
	public static func split(_ string: String, _ delimiter: String) -> [String] {
		return string.components(separatedBy: delimiter)
	}
    /**
     * New
     */
	public static func firstWord(_ string: String) -> String {
       return string.components(separatedBy: " ")[0]
    }
    /**
     * Returns the last char
     */
   public static func lastChar(_ string: String) -> String {
        //let lastCharIndex:Int = string.characters.count - 1
        //print(lastCharIndex)
        return String(describing: string.string.last)//swift 3 upgrade -> was: String()
    }
    /**
     * substring("Hello from Paris, Texas!!!", 11,15); // output: Pari
     * - Note: get last 4 chars: String(a.suffix(4)) or a.substring(from:a.index(a.endIndex, offsetBy: -4))
     * - Important: FROM swift 4 we rather do:
     * let newStr = str[..<index] The same stands for partial range from operators, just leave the other side empty:
     * let newStr = str[index...] Keep in mind that these range operators return a Substring. If you want to convert it to a string, use String's initialization function:
     * let newStr = String(str[..<index])
     * let newStr = str[str.index(str.startIndex, offsetBy: 0)..<str.index(str.endIndex, offsetBy: str.count)]
     */
    public static func subString(_ str: String, _ beginning: Int, _ end: Int) -> String {
        let range = str.stringRange(str, beginning, end: end)
        let retVal = str[range.lowerBound..<range.upperBound] // swift 4 upgrade, was: return str.substring(with:range)
        return String(retVal)
    }
    /**
     * substr("Hello from Paris, Texas!!!",11,15); // output: Paris, Texas!!!
     * - NOTE: ref: https://stackoverflow.com/a/39677704/5389500
     */
    public static func subStr(_ str: String, _ beginning: Int, _ len: Int) -> String {
       //str.stringRange(str, beginning, len:len)
        let start = str.index(str.startIndex, offsetBy: beginning)
        let end = str.index(str.startIndex, offsetBy: beginning + len)
        let retVal = str[start..<end]//swift 4 upgrade, was: return str.substring(with:range)
        return String(retVal)
    }
    /**
     * Splits a string at the first occurrence of a delimiter string
     * ## Examples:
     * splitAtFirst(str: "element=value", delimiter: "=") // "element", "value"
     */
    public static func splitAtFirst(str: String, delimiter: String) -> (a: String, b: String)? {
       guard let upperIndex = (str.range(of: delimiter)?.upperBound), let lowerIndex = (str.range(of: delimiter)?.lowerBound) else { return nil }
       let firstPart: String = .init(str.prefix(upTo: lowerIndex))
       let lastPart: String = .init(str.suffix(from: upperIndex))
       return (firstPart, lastPart)
    }
    /**
     * Returns the index of the first match of PARAM: b in PARAM: a
     * New: if the PARAM: b isnt present in PARAM a then return -1 indicating the string was not found
     */
    public static func indexOf(_ a: String, _ b: String) -> Int {
        guard let range: Range<String.Index> = StringRangeParser.rangeOf(a, b) else { return -1 }
        return a.distance(from: a.startIndex, to: range.lowerBound)
    }
    /**
     * Returns str sans the first char
     * - NOTE: does not modify the original string
     */
    public static func sansPrefix(_ str: String) -> String {
        return String(str.string.dropFirst())
    }
    /**
     * Returns str sans the last char
     * - NOTE: does not modify the original string
     */
    public static func sansSuffix(_ str: String) -> String {
        return String(str.string.dropLast())
    }
    /**
     * - NOTE: only works with Character (make one that supports longer strings later)
     */
    public static func trim(_ str: String, _ left: Character, _ right: Character) -> String {
        var str = str
        str = trimLeft(str, right)
        str = trimRight(str, right)
        return str
    }
    /**
     * trims left
     */
    public static func trimLeft(_ str: String, _ left: Character) -> String {
        var str = str
        if str.string.first == left { str = String(str.string.dropFirst()) }
        return str
    }
    /**
     * trims right
     * - Fixme: ⚠️️ Create trimRight for str as well
     */
    public static func trimRight(_ str: String, _ right: Character) -> String {
        var str = str
        if str.string.last == right { str = String(str.string.dropLast()) }
        return str
    }
    /**
     * Convenience
     * ## EXAMPLES:
     * "32\n".trim("\n").int//32
     */
    public static func trim(_ str: String, _ leftAndRight: Character) -> String {
        return trim(str, leftAndRight, leftAndRight)
    }
    public static func boolean(_ string: String) -> Bool {
        return string == "true"
    }
    /**
     * Works with \n and \r
     */
    public static func lineCount(_ str: String) -> Int {
        let newLineSet = NSCharacterSet.newlines
        let arr = str.components(separatedBy: newLineSet)
        let count = arr.count
        return count
    }
    /**
     * Returns the cooresponding String.Index for PARAM: index:Int
     * ## Examples:
     * "🚀ship".idx(1)//the String.Index between 🚀 and ship
     */
    public static func idx(_ str: String, _ index: Int) -> String.Index {
        return str.index(str.startIndex, offsetBy: index)/*Upgraded to swift 3-> was: startIndex.advancedBy*/
    }
    /**
     * Basically enables you to convert a string to any kind of Array of char in any kind of type
     * ## EXAMPLES:
     * "001".array({$0.int}) -> [0,0,1]
     */
    public static func array<T>(_ str: String, _ cast: (_ char: Character) -> T) -> [T] {
        let arr: [T] = str.string.map { cast($0) }
        return arr
    }
    /**
     * Counts how many times a string appears in a string
     */
    public static func occurrences() {
        //impliment this
    }
    /**
     * Prefix an int with a set amount of characters
     * ## Examples:
     * prefix(value:6, padCount:3, padStr:"0")//"006"
     * - Important: there is a native equivilent for this method: String(format: "%02d", myInt)
     */
     public static func prefix(input: Int, padCount: Int, padStr: String) -> String {
         let padding: String = padStr * (padCount - String(input).count)
         if String(input).count < padCount {
            return padding + String(input)
         } else {
            return String(input)
         }
     }
}

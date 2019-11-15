import Foundation

public class StringModifier {
    /**
     * Returns an array with many strings
     */
    public static func split(_ str: String, _ delimiter: String) -> [String] {
        return str.components(separatedBy: delimiter)
    }
    /**
     * ## Examples:
     * splitAtFirst(str: "element=value", delimeter: "=") // (element,value)
     */
    public static func splitAtFirst(str: String, delimeter: String) -> (a: String, b: String)? {
      guard let upperIndex = (str.range(of: delimeter)?.upperBound), let lowerIndex = (str.range(of: delimeter)?.lowerBound) else { return nil }
      let firstPart: String = .init(str.suffix(from: upperIndex))
      let lastPart: String = .init(str.prefix(upTo: lowerIndex))
      return (firstPart, lastPart)
    }
    /**
     * Removes the first occurence of the the prefix
     */
    public static func removePrefix(str: String, prefix: String) -> String {
        guard str.hasPrefix(prefix) else { return str }
        return String(str.dropFirst(prefix.count))
    }
    /**
     * Removes suffix from string
     */
    public static func removeSuffix(str: String, suffix: String) -> String {
        guard str.hasSuffix(suffix) else { return str }
        return String(str.dropLast(suffix.count))
    }
    /**
     * - NOTE there is also inline: input.remove(at: input.index(before: input.endIndex))
     * - Note: There is also: String(str.dropLast(1))
     */
    public static func removeLastChar(_ input: String) -> String {
        let retVal = input[..<input.index(before: input.endIndex)]
        return String(retVal)//Swift 4 upgrade, was: input.substring(to: input.index(before: input.endIndex))
    }
    /**
     *	Removes all instances of the remove string in the input string
     *	- RETURN: A String with the remove string removed
     *	- PARAM: input: The string that will be checked for instances of remove string
     *	- PARAM: remove: The string that will be removed from the input string
     */
    public static func removeEvery(_ input: String, _ match: String) -> String { // :Fixme: test if this works when nothing is removed because replace was changed
        return StringModifier.replaceEvery(input, match, "")
    }
    /**
     * replaceEvery("abc 123 abc 123","123","abc")
     */
    public static func replaceEvery(_ str: String, _ match: String, _ replacment: String) -> String {
        let replaced = str.replacingOccurrences(of: match, with: replacment)
        return replaced
    }
    /**
     * Replaces first match
     * Replaces PARAM: match in PARAM: input with PARAM: replacement
     * ## EXAMPLES:
     * replaceFirst("Hello" + " " + "😄","😄","🐈") // Hello 🐈
     * - NOTE: you can also do: "magic.zip".replacingOccurrences(of: "zip", with: "jpg")//magic.jpg
     */
    public static func replaceFirst(_ input: String, _ match: String, _ replacement: String) -> String {
        var input = input
        input.insert(contentsOf: replacement.string, at: input.range(of: match)!.lowerBound)
        input.removeSubrange(input.range(of: match)!)
        return input
    }
    /**
     * ## EXAMPLES:
     * combine(["Andrew", "Ben", "John", "Paul", "Peter", "Laura"]," ")//"Andrew Ben John Paul Peter Laura"
     */
    public static func combine(_ strings: [String], _ seperator: String) -> String {
        return strings.joined(separator: seperator)
    }
	public static func wrapWith(_ string: String, _ wrapper: String) -> String {
	   return wrapper + string + wrapper
	}
	/**
	 * Returns a reversed strin
	 * - NOTE: does not modify the original string
	 * - NOTE: shorter version of this method: 		return string.sort( { (s1: String, s2: String) -> Bool in return s1 > s2 } )//closure expression syntax
	 * - NOTE: even shorter string.sort( { s1, s2 in return s1 > s2 } )//infered version of the bellow:
	 * - NOTE: even shorter: string.sort( { s1, s2 in s1 > s2 } )//the return statement is omitted as it is implicit
	 * - NOTE: even shorter: string.sort( { $0 > $1 } )//shorthand argument names, the in is omitted since the expression is made up entirly of its body
	 * - NOTE: even shorther string.sort(>)//operator function
	 * - NOTE: keep the long version around so that its easier to understand
     * ## Examples:
     * reverse("hello")//"olleh"
	 */
	public static func reverse(_ str: String) -> String {
        return String(str.string.reversed())
	}
	public static func capitalize(_ string: String) -> String {
		return string.capitalized
	}
    /*
     * Returns a lowercase string
     */
    public static func lowerCase(_ string: String) -> String {
       return string.lowercased()
    }
    /*
     * Returns an uppercase string
     */
    public static func upperCase(_ string: String) -> String {
        return string.uppercased()
    }
    /*
     * Returns PARAM: string with the first character capitalizesed,
     * - NOTE: Can also be done through replaceRange: string.replaceRange(string.startIndex...string.startIndex, with: String(string[string.startIndex]).capitalizedString) //we use replaceRange in combination with the .capitalizedString method // string[string.start.index] returns a Character instance. then we cast this as a string
     */
    public static func capFirstChar(_ str: String) -> String {
        let firstChar: Character = CharacterParser.charAt(str, 0)
        let theRest: String = StringParser.subString(str, str.string.count, 1)
        return String(firstChar) + theRest
    }
    /**
     * Returns a new string from PARAM: str with a new PARAM: char inserted at PARAM: index
     */
    public static func insertCharAt(_ str: String, _ char: Character, _ index: Int) -> String {
        var str = str
        let strIndex = str.idx(index)
        str.insert(char, at: strIndex)
        return str
    }
    /**
     * Inserts multiple chars at multiple indecies
     * - NOTE: the order of the charsAndIndicies doesnt matter, its sorted in this method
     * - NOTE: We could make this method inout, but then we cant do things like "test".insertCharsAt (for longer strings that would benefit from inout we could make a custom method)
     */
    public static func insertCharsAt(_ str: String, _ charsAndIndicies: [(char: Character, index: Int)]) -> String {
        var charsAndIndicies = charsAndIndicies
        var str = str
        charsAndIndicies.sort { $0.index > $1.index }/*sort from highest index to lowest*/
        charsAndIndicies.forEach {/*we loop backwards because looping forward and you would lose the indecies*/
            let strIndex = str.idx($0.index)
            str.insert($0.char, at: strIndex)
        }
        return str
    }
    /**
     * Returns PARAM: a with the content of PARAM: b inserted at PARAM: i
     * - NOTE: Can also be done through replaceRange: string.replaceRange(string.startIndex...string.startIndex, with: String(string[string.startIndex]).capitalizedString) //we use replaceRange in combination with the .capitalizedString method // string[string.start.index] returns a Character instance. then we cast this as a string
     * - NOTE: Does not alter the original strings
     */
    public static func insertAt(_ a: String, _ b: String, _ i: Int) -> String {
        var a = a
        let index = a.idx(i)
        a.insert(contentsOf: b.string, at: index)
        return a
    }
    /**
     * Returns a new string that has that has a section of its text replaced with PARAM: b, the section is from PARAM: start to PARAM: end
     * ## EXAMPLES:
     * replaceRange("Finland", 2,3,"NLA")//fiNLAnd
     * - Fixme: probably use inout
     */
    public static func replaceRange(str: String, _ replacement: String, _ start: Int, _ end: Int) -> String {
        var str = str
        let range: Range<String.Index> = StringRangeParser.stringRange(str, start, end)
        str.replaceSubrange(range, with: replacement)
        return str
    }
    /**
     * Trims all whitespace from left and right of PARAM: str
     * - NOTE: the original string is not modified
     * - NOTE: you can also use: NSCharacterSet.whitespaceAndNewlineCharacterSet()
     * ## EXAMPLES:
     * trimWhiteSpace("    Let's trim the whitespace    ")//"Let's trim the whitespace"
     */
    public static func trimWhiteSpace(_ str: String) -> String {
        //hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).
        return str.trimmingCharacters(in: .whitespaces)
        //NSCharacterSet.whitespaceCharacterSet()
    }
}

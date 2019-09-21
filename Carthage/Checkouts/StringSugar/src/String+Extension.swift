import Foundation
/**
 * Swift 4 brings: string.count, string.isEmpty, string.dropFirst(),string.reversed(), string.filter { … }
 */
/**
 * Convenince extensions for often used string methods
 */
extension String {
    //init(_ value:Any) doesnt work as String("hello".reversed()) must go through
    public init(_ value: CGFloat) { self.init(describing: value) }/*Brings back simple String casting which was removed in swift 3*/
    public init(_ value: Int) { self.init(describing: value) }/*Brings back simple String casting which was removed in swift 3*/
    public init(_ value: Bool) { self.init(describing: value) }/*Brings back simple String casting which was removed in swift 3*/
}
/**
 * Asserters
 */
extension String {
    public var bool: Bool { return StringParser.boolean(self) }
    public var isLowerCased: Bool { return StringAsserter.lowerCase(self) }
    public func beginsWith(_ prefix: String) -> Bool {
        return StringAsserter.beginsWith(self, prefix)
    }
    public func endsWith(_ suffix: String) -> Bool {
        return StringAsserter.endsWith(self, suffix)
    }
    public func isWrappedWith(_ str: String) -> Bool {
        return StringAsserter.isWrappedWith(self, str)
    }
}
/**
 * Parsers
 */
extension String {
    /**
     * ## EXAMPLES:
     * "this is cool".split(" ")//output: ["this","is","cool"]
     */
    public func split(_ delimiter: String) -> [String] {/*Convenince*/
        return StringParser.split(self, delimiter)
    }
    /**
     * - Fixme: ⚠️️ Rename to var encoded
     */
    public func encode() -> String? {/*Convenince*/
        return StringParser.encode(self)
    }
    /**
     * - Fixme: ⚠️️ Rename to var decoded
     */
    public func decode() -> String? {/*Convenince*/
        return StringParser.decode(self)
    }
    public func subStr(_ i: Int, _ len: Int) -> String {/*Convenince*/
        return StringParser.subStr(self, i, len)
    }
    public func subString(_ beginning: Int, _ end: Int) -> String {/*Convenince*/
        return StringParser.subString(self, beginning, end)
    }
    public func indexOf(_ b: String) -> Int {/*Convenince*/
        return StringParser.indexOf(self, b)
    }
    public func trim(_ leftAndRight: Character) -> String {/*Convenince*/
        return StringParser.trim(self, leftAndRight)
    }
    public func trimRight(_ right: Character) -> String {/*Convenince*/
        return StringParser.trimRight(self, right)
    }
    public func trimLeft(_ left: Character) -> String {/*Convenince*/
        return StringParser.trimLeft(self, left)
    }
    public func idx(_ index: Int) -> String.Index {
        return StringParser.idx(self, index)
    }
   /**
    * - Remark: You can also do: str.index(str.startIndex, offsetBy: index)
    * - Note : natively like this: str.index(str.startIndex, offsetBy: 0)..<str.index(str.endIndex, offsetBy: str.count)
    */
    public func stringRange(_ str: String, _ beginning: Int, end: Int) -> Range<String.Index> {
        let startIndex = str.idx(beginning)
        let endIndex = str.idx(end/*-beginning*/) // <-- this was a bug
        return startIndex..<endIndex
    }
   /**
    * Fixme: Write Doc
    */
    public func stringRange(_ str: String, _ beginning: Int, len: Int) -> Range<String.Index> {//startIndex..<endIndex
        let startIndex = str.idx(beginning)
        let endIndex = str.idx(beginning + len)
        return startIndex..<endIndex//swift 3 upgrade, was->Range(start:startIndex,end:endIndex)
    }
    public func array<T>(_ cast: (_ char: Character) -> T) -> [T] {
        return StringParser.array(self, cast)
    }
    /**
     * - CAUTION: if you do "0xFF0000FF".uint it will give the wrong value, use UInt(Double("")!) instead for cases like that
     */
    public var uint: UInt { return UInt(Float(self)!) }
    /**
     * ## EXAMPLES:
     * "<p>text</p>".xml//Output: xml
     */
//    var xml: XML { return XML(self) }/*Convenince*/
//    var url: URL? { return FilePathParser.path(self) }/*Convenince*/
    public var lineCount: Int { return StringParser.lineCount(self) }
//    var content: String? { return FileParser.content(self.tildePath) }
//    var nsColor: NSColor { return StringParser.nsColor(self) }
//    var int:Int{return Int(self)!}
    public var int: Int? { return Int(self) }
    /**
     * Since swift 4 There is also native count, But it doesn't return Int
     * - NOTE: was: var count:Int { return self.characters.count } but chatacters is no more in swift 4.1
     * ## EXAMPLES:
     * "abc👌".count//Output: 4
     */
    public var count: Int {
        return self.distance(from: self.startIndex, to: self.endIndex)
    }
    public var cgFloat: CGFloat { return CGFloat(Double(self)!) } //Fixme: you should also do the same for the Any type
    public var double: Double { return Double(self)! }
//    var json: Any? { return JSONParser.json(self) }
    /**
     * from user agnostic to absolute URL
     */
    public var tildePath: String { return NSString(string: self).expandingTildeInPath }/*Convenince*/
    /**
     * Makes file paths user agnostic (~ instad of hardcoded user)
     * - NOTE: from absolute to "relative" URL
     * ## EXAMPLES:
     * "Users/John/Desktop".tildify//Output:~/Desktop
     */
    public var tildify: String { return NSString(string: self).abbreviatingWithTildeInPath }/*Convenince*/
}
/**
 * Modifiers
 */
extension String {
    public func insertCharsAt(_ charsAndIndicies: [(char: Character, index: Int)]) -> String {
        return StringModifier.insertCharsAt(self, charsAndIndicies)
    }
    public func removeLastChar() -> String { return StringModifier.removeLastChar(self) }
    /**
     * - NOTE: remember to tildeExpand the filePath
     */
//    func write(filePath: String) -> Bool {
//        return FileModifier.write(filePath, content: self)
//    }
}
extension NSString {
    public var string: String { return String(self) }/*Convenience*/
}
extension Bool {
    public var str: String { return self.description }
}
extension String {
   /**
    * Multiplies a string
    * ## EXAMPLES:
    * "hello" * 3 //hellohellohello
    */
   public static func * (left: String, right: Int) -> String {
      return (0..<right).indices.reduce("") { interim, _ in
         interim + left
      }
   }
}
/**
 * UI-related
 */
extension String {
   #if os(iOS)
   public typealias Font = UIFont
   #elseif os(macOS)
   public typealias Font = NSFont
   #endif
    /**
     * - NOTE: for Single Line
     * Alternativly: let size = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:18.0)])
     */
    public func textWidth(font: String.Font?) -> CGFloat {
      let attributes = font != nil ? [NSAttributedString.Key.font: font!] : [:]
        let w = self.size(withAttributes: attributes).width
        return w
    }
}

/**
 * Error
 */
//extension String: Error {}/*Then you can just throw a string*/
//extension String: LocalizedError {/*adds error.localizedDescription*/
//    public var errorDescription: String? { return self }
//}

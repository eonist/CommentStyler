import Foundation
import RangeSugarIOS
/**
 * Mutating
 * Fixme: split into extensions
 */
extension Array {
   /**
    * convenience method
    */
    public mutating func shift() -> Element {/**/
        return ArrayModifier.shift(&self)
    }
    /**
     * Convenience method
     */
    public mutating func pop() -> Element? {
        return ArrayModifier.pop(&self)
    }
    /**
     * Convenience method
     */
    public mutating func pushPop(_ item: Element) -> [Element] {/*convenience*/
        return ArrayModifier.pushPop(&self, item)
    }
    /**
     * Enables the Array as a varadic method:
     * - NOTE: Variadic functions are functions that have a variable number of arguments (indicated by ... after the argument's type) that can be accessed into their body as an array.
     * - CAUTION: renaming appendMany to just append can cause problems with some array's so its probably better to leave it named something different than the native append name
     * ## EXAMPLES:
     * var arr:Array<Int> = [0,1,2]
     * arr.appendMany(3,4,5)
     * Swift.print(arr)//[0,1,2,3,4,5]
     */
    public mutating func appendMany(_ items: Element...) {
        self += items
    }
    /**
     * Convenience method
     */
    public mutating func splice2(_ startIndex: Int, _ deleteCount: Int, _ values: [Element] = []) -> [Element] {
        return ArrayModifier.splice2(&self, startIndex, deleteCount, values)
    }
    /**
     * Convenience method
     */
    public mutating func unshift(_ item: Element) -> Int {
        return ArrayModifier.unshift(&self, item)
    }
    /**
     * Convenience method
     */
    public mutating func prepend(_ item: Element) -> Int {/*the name is more descriptive than unshift, easier to reason about*/
        return ArrayModifier.unshift(&self, item)
    }
    /**
     * - Note: there is also native: removeAtIndex(index: Int) -> Element
     * - Remark: 1 equals, does not exist
     */
    public mutating func removeAt(_ i: Int) {
      _ = ArrayModifier.removeAt(array: &self, i: i)
        //if i != -1 { _ = self.splice2(i, 1) }
    }

   /**
    * Removes first item in array if available
    * ## Examples:
    * var arr = ["1","2"]
    * arr.removeFirst("1")
    * Swift.print("arr:  \(arr)") // ["2"]
    */
   @discardableResult
   public mutating func removeFirst(_ item: inout Element) -> Element? {
      return ArrayModifier.delete(&self, &item)
   }
    /**
     * Convenience method
     */
    public mutating func shiftAppend(_ item: Element) -> [Element] {
        return ArrayModifier.shiftAppend(&self, item)
    }
    /**
     * Convenience method
     */
    public mutating func displace( _ from: Int, _ to: Int) -> [Element] {
        return ArrayModifier.displace(&self, from, to)
    }
    /**
     * Convenience method
     */
    public mutating func insertAt(_ item: Element, _ index: Int) -> [Element] {
        return ArrayModifier.insertAt(&self, item, index)
    }
    /**
     * IMPORTANT: ⚠️️ you can also use the native [1,2,3,4,5][0..<3]//[1,2,3]//⚠️️ does not support all array types, Casting as array helps sometimes: Array([1,2,3,4,5][0..<3])
     */
    public func slice2(_ startIndex: Int, _ endIndex: Int) -> [Element] {/*Convenince*/
        return ArrayModifier.slice2(self, startIndex, endIndex)
    }
}
/**
 * Parsing
 */
extension Array {
    /**
     * - NOTE: the concat method is not like append. Append adds an item to the original array, concat creates a new array all together.
     * - NOTE: If you need a mutating concatination behaviour use the += operator
     * - IMPORTANT: this method was mutating before, but that wasn't the intended behaviour!?!
     */
    public func concat(_ array: [Element]) -> [Element] {
        return self + array
    }
    /**
     * Convenince method
     * IMPORTANT: this method was mutating before, but that wasn't the intended behaviour!?!
     * NOTE: If you need a mutating concatination behaviour use the += operator
     */
    public func concat(_ item: Element) -> [Element] {
        return concat([item])
    }
    /**
     * A neat way to cast Array's (Since swift/obj-c has made casting array's cumbersome at times)
     * - NOTE: figure out a way to make it work with inout methods aswell
     * - NOTE: You may also not provide a type and the type will be infered automatically
     * - NOTE: You can cast arrays with protocol instances to class types like NSView. (Great way to maintain a protocol based design)
     * - CAUTION: using the map method isn't exactly the most optimized way to cast, but sometimes optimizing isnt needed, with small arrays etc, Also sometimes designing around using map can cause you to over design things in code
     */
    public func cast<T>(_ type: T.Type? = nil) -> [T] {
        return self.map { $0 as! T }
    }
    /**
     * Asserts if PARAM: idx is within the bounds of the array
     */
    public func valid(_ idx: Int) -> Bool {
        return !self.isEmpty && idx > -1 && idx < self.count
    }
    public func first(_ match: Element, _ condition: (_ a: Element, _ b: Element) -> Bool) -> Element? {
        return ArrayParser.first(self, match, condition)
    }
    public func removeDups( _ condition:(_ a: Element, _ b: Element) -> Bool) -> [Element] {
        return ArrayModifier.removeDups(self, condition)
    }
    public func mapReduce<V, U>(_ result: V, _ closure:@escaping (_ interim: V, _ item: Element) -> V ) -> U {
        return ArrayParser.mapReduce(self, result, closure)
    }
    /**
     * Sometimes you wan't to do stuff only if an array has items: if let arr = [].optional {...}
     */
    public var optional: Array? {
        return self.isEmpty ? nil : self
    }
    public var start: Element? { // new
        get { return self.first }
        set { self[0] = newValue! }
    }
    public var end: Element? {//new
        get { return self.last }
        set { self[self.isEmpty ? 0 : self.count - 1] = newValue! }
    }
    /**
     * - RATIONAL 1: Enhances readability when doing `if let` style coding
     * - RATIONAL 2: using if let in conjunction with array avoids out of bound crashing
     * - NOTE: Performance wise `self.dropFirst(at).first` is as fast as doing .contain,
     * - ⚠️️IMPORTANT:⚠️️ Do not use this with arrays such as :[Int?], Fixme: ⚠️️ should we rather do idx < .count?
     * ## EXAMPLES:
     * if let item = [a,b,c,d][safe:3] {print(item)}
     * - Note: you can also do Optional(arr[4]) maybe? no you cant, will be an error
     * - Note: You can do: arr.count < idx ? arr[idx] : nil
     */
    public subscript(safe index: Index) -> Iterator.Element? {
        if indices.contains(index) { return self[index] }
        return nil
    }
}
/**
 * NOTE: only applicable to Array<AnyObject>
 */
extension Array where Element: AnyObject {
    public func indexOf(_ item: AnyObject) -> Int {
        return ArrayParser.indexOf(self, item)
    }
}
extension Array where Element: Comparable {
    public func index(_ value: Element) -> Int {
        return ArrayParser.index(self, value)
    }
    public func has(_ value: Element) -> Bool {
        return self.firstIndex(of: value) != nil
    }
    /**
    * Returns the last index that match condition
    * ## Examples:
    * [0,55,14,55,22,33,55,76,120].lastIndex(where: {$0 == 55}// 6
    * - Note: This is now an native method: dataArr.lastIndex(where: {})
    */
   public func lastIndex(where condition: (Element) -> Bool) -> Int? {
      guard let idx: Int = self.reversed().firstIndex(where: condition) else { return nil }
      return self.count - 1 - idx
   }
}
extension Array where Element: Equatable {
    public func existAtOrBefore(_ idx: Int, _ item: Element) -> Bool {
        return ArrayAsserter.existAtOrBefore(self, idx, item)
    }
}
/**
 * [1,2,3].string//"123"
 * - NOTE: you can also use .joined but reduce does the same I suppose
 */
extension Array where Element: BinaryInteger {
    public var string: String { return self.map { "\($0)" }.reduce("") { $0 + $1 } }
}
//extension Array where Element:ExpressibleByStringLiteral{
extension Collection where Iterator.Element == String {//SubSequence.Iterator.Element == String
    public var hash: [String: Int] {
        return AdvanceArrayParser.hash(self as! [String])
    }
}

public protocol AnyArray {}/*<--Neat trick to assert if a value is an Array, use-full in reflection and when the value is Any but really an array*/
extension Array: AnyArray {}//Maybe rename to ArrayType
extension NSArray: AnyArray {}/*<-empty arrays are always NSArray so this is needed*/

extension Array {
   /**
    * ## Examples
    * var arr = [1,2,3]
    * arr += 4
    * print(arr)//1,2,3,4
    * - Returns array for the sake of convenience
    */
   public static func +=<T> ( left:inout [T], right: T) -> [T] {
      left.append(right)
      return left
   }
   /**
    * var arr = [2,3,4]
    * 1 += arr
    * print(arr)//1,2,3,4
    * - Returns array for the sake of convenience
    */
   public static func +=<T> (left: T, right:inout [T]) -> [T] {
      _ = right.unshift(left) // <--this is like prepend
      return right
   }
}

/*Advance array extensions*/
extension Collection {
   /**
    * Multidimensional-flat-map...because flatMap only works on "2d arrays". This is for "3d array's"
    * - Note: A 3d array is an array structure that can have nested arrays within nested arrays infinite addendum
    * - Note: Alternate names for this method as suggest by @defrenz and @timvermeulen on slack swift-lang #random: `recursiveFlatten` or `recursiveJoined`
    * ## Examples:
    * let arr:[Any] = [[[1],[2,3]],[[4,5],[6]]] 👈 3d array (3 depths deep)
    * let x2:[Int] = arr.recursiveFlatmap()
    * Swift.print(x2)//[1,2,3,4,5,6]
    */
   public func recursiveFlatmap<T>() -> [T] {
      var results = [T]()
      for element in self {
           if let sublist = element as? [Self.Iterator.Element] { // Array
               results += sublist.recursiveFlatmap()
           } else if let element = element as? T { // Item
               results.append(element)
           }
      }
      return results
   }
}

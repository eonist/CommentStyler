import Foundation
/**
 * Fixme: Make Unique that uses Set
 * More inspiration here: https://appventure.me/2015/11/30/reduce-all-the-things/
 */
public class ArrayParser {
    /**
     * - NOTE: This method compares value not reference
     * - NOTE: String class works with Comparable and not Equatable, Use this method when dealing with Strings
     * - NOTE: you can also do things like {$0 > 5} , {$0 == str}  etc
     * - NOTE: this may also work: haystack.filter({$0 == needle}).count > 0
     * - NOTE: the multiple generig type could also be written like this: <T : protocol<Equatable, Comparable>>
     * - NOTE: there is also Native: [].index(where: {$0 == val})
     * - IMPORTANT: ⚠️️ If you want to compare String, int, CGFloat etc use this as is,
     * - IMPORTANT: ⚠️️ if you want to compare custom classes, then you should compare reference or
     * - IMPORTANT: ⚠️️ if you want to compare values then you must implement Equatable or COmparable in this class
     * ## EXAMPLES:
     * ArrayParser.index(["abc","123","xyz","456"], "xyz")//2
     * indexOf(["Apples", "Peaches", "Plums"],"Peaches")//1
     */
    public static func index<T>(_ array: [T], _ value: T) -> Int where T: Comparable {//the <T: Comparable> The Comparable protocol extends the Equatable protocol -> implement both of them
        return array.firstIndex(of: value) ?? -1
    }
    /**
     * - NOTE: If you want to compare values rather than references. Then use the "==" compare operator and make sure you test if an instance is of String or Int or CGFloat etc. and then cast it to that type before you attempt to use the "==" operator. AnyObject in of it self cant be tested with the == operator. I can definitely see the use case for testing value rather than ref.
     * - IMPORTANT: ⚠️️ compares reference not value
     * - NOTE: use native arr.index(where {..}) ?? -1 instead
     * - Fixme: ⚠️️ maybe this can be cleaned up with Any?
     */
    public static func indx<T>(_ arr: [T], _ item: T) -> Int { // <--use inout for both args?
      // Fixme: ⚠️️ I dont think the casting to anyobject is needed
        return arr.firstIndex { ($0 as AnyObject) === (item as AnyObject) } ?? -1
    }
    /**
     * - NOTE: I feel this is the best implementation as it doesn't copy anything, "direct comparison" with the inout args
     * - NOTE: dupplets doesn't seem to be castable to AnyObject
     * - NOTE: Compares reference not value
     */
    public static func idx<T>(_ arr:inout [T], _ item:inout T) -> Int {
        return arr.firstIndex { ($0 as AnyObject) === (item as AnyObject) } ?? -1//we cast to AnyObject because generics can't ref compare, but AnyObject can
    }
    /**
     * Returns the index of the first instance that matches the PARAM: item in the PARAM: arr, -1 of none is found
     * - NOTE: works with AnyObject aswell. Unlike the apple provided array.indexOf that only works with Equatable items
     * - IMPORTANT: This method only works with instances that are casted as AnyObject, use the indx method instead as it is cleaner
     * - IMPORTANT: compares reference not value
     */
    public static func indexOf(_ arr: [AnyObject], _ item: AnyObject) -> Int {
        return arr.firstIndex { $0 === item } ?? -1
    }
    /**
     * Returns an array with itmes that are not the same in 2 arrays
     * ## EXAMPLES:
     * difference([1,2,3],[1,2,3,4,5,6]);//4,5,6
     * - IMPORTANT: compares value not reference (If you need support for ref make a new method)
     */
    public static func difference<T>(_ a: [T], _ b: [T]) -> [T] where T: Comparable {
        var diff: [T] = []
        for item in a { if ArrayParser.index(b, item) == -1 { diff.append(item) } }
        for item in b { if ArrayParser.index(a, item) == -1 { diff.append(item) } }
        return diff
    }
    /**
     * Simple diffing method (EXPERIMENTAL)
     * ## EXAMPLES:
     * diff(["a","b","c"],["a","b","c","d","e","f","g"]); // (b:4,5,6)
     */
    public static func diff<T>(_ a: [T], _ b: [T] ) -> (a: [Int], b: [Int]) where T: Comparable {
        var (diffA, diffB): ([Int], [Int]) = ([], [])
        for (i, item) in a.enumerated() { if b.firstIndex(of: item) == nil { diffA.append(i) } } // Fixme: use where here?
        for (i, item) in b.enumerated() { if a.firstIndex(of: item) == nil { diffB.append(i) } }
        return (a: diffA, b: diffB)
    }
    /**
     * Returns an array with itmes that are not the same in 2 arrays
     * ## EXAMPLES:
     * difference([1,2,3],[1,2,3,4,5,6]); // 4,5,6
     * - IMPORTANT: compares reference not value
     */
    public static func difference<T>(_ a: [T], _ b: [T]) -> [T] {
        var diff: [T] = []
        for item in a { if ArrayParser.indx(b, item) == -1 { diff.append(item) } }
        for item in b { if ArrayParser.indx(a, item) == -1 { diff.append(item) } }
        return diff
    }
    /**
     * ## EXAMPLES: similar([1, 2, 3, 10, 100],[1, 2, 3, 4, 5, 6])
     * - NOTE: the orgiginal version of this method is a little different, it uses an indexOf call
     * - IMPORTANT: this compares value similarity not reference, make a similar method if its needed for references aswell, or add some more logic to this method to support both. A bool flag can differentiate etc
     */
    public static func similar<T: Equatable>(_ a: [T], _ b: [T]) -> [T] { // Fixme: Add support for COmparable to this method
       return a.filter { x in b.contains { x == $0 } }
    }
    /**
     * Returns a list unique with all the unique Int from PARAM: ints
     * ## EXAMPLE: unique([1, 2, 3, 1, 2, 10, 100])//[1, 2, 3, 10, 100]
     * - Fixme: there are probably more functional ways of doing this method 🤖 yes there is use reduce or set
     */
    public static func unique(_ ints: [Int]) -> [Int] { // use comparable instead of int, see RangeAsserter for example for how to implement that
        var uniqueList: [Int] = []
        ints.forEach { number in
            var numberIsNew = true
            for otherNumber in uniqueList where number == otherNumber {
               numberIsNew = false
               break
            }
            if numberIsNew { uniqueList.append(number) }
        }
        return uniqueList
    }
    /*
    * unique([1,2,3,4,5], limit: 3) // 4,2,5
    */
    public static func unique<T>(_ elements: [T], limit: Int) -> [T] {
      let shuffledIndices = (0..<elements.count).indices.shuffled()
      let uniqueRandomIndecies = shuffledIndices[(0..<Swift.min(elements.count, limit))]
      return uniqueRandomIndecies.map { elements[$0] }
    }
    /**
     * Returns the first item in an array
     * - NOTE: there is also the native: [1,2,3].first//1
     */
    public static func first<T>(_ arr: [T]) -> T {
        return arr[0]
    }
    /**
     * Returns the last item in an array
     * - NOTE: there is also the native: [1,2,3].last//3
     */
    public static func last<T>(_ arr: [T]) -> T {
        return arr[arr.count - 1]
    }
    /**
     * Returns a new array with every item in PARAM: array sorted according a custom method provided in PARAM: contition
     * - NOTE: leaves the original array intact
     * - NOTE: ⚠️️ there is also Native: .sort and .sortInPlace
     * ## EXAMPLES:
     * Print(ArrayParser.conditionSort([4,2,5,1,0,-1,22,3],<));// -1,0,1,2,3,4,5,22
     */
    public static func conditionSort<T>(_ array: [T], _ condition: (_ a: T, _ b: T) -> Bool) -> [T] {
        var sortedArray: [T] = []
        array.forEach {
            let index: Int = Utils.index($0, sortedArray, condition)
            if index > -1 { _ = ArrayModifier.splice2(&sortedArray, index, 1, [$0, sortedArray[index]]) }
            else { sortedArray.append($0) } /*add the weightedStyle to index 0 of the sortedStyles array or weigthedStyle does not have priority append weightedStyle to the end of the array */
        }
        return sortedArray
    }
    /**
     * Returns the first item in PARAM: array that is of PARAM: type
     * - Fixme: ⚠️️ rename to first?
     */
    public static func firstItemByType<T>(_ array: [Any?], type: T.Type) -> T? {
        return array.first { $0 as? T != nil } as? T
    }
    /**
     * Returns all items in PARAM: array that is of PARAM: type
     * - NOTE: You can also do: `items.lazy.flatMap{$0 as? NSView}.first`
     */
    public static func itemsByType<T>(_ array: [Any?], type: T.Type) -> [T] {
        return array.filter { $0 as? T != nil }.map { $0 as! T }
    }
    /**
     * Think of this method as: firstOccurence of something
     * Returns the first item that matches PARAM: match according to the constraints in PARAM: method
     * ## EXAMPLES:
     * ["a","b","c"].first("b",{$0 == $1})//b
     * [("a",0),("b",1)].first("b",{$0.0 == $1}).1//b
     * [(id:"a",val:0),(id:"b",val:1)].first("b",{$0.id == $1}).val//b
     * - NOTE: This method should have an extension, but making an extension for two generic variables proved difficult, more research needed, for now use the ArrayParser.first method call
     * - NOTE: you could do: arr.forEach{/*assert logic goes here*/} but forEach can't return early so you are forced to iterate the entire list
     */
    public static func first<T, V>(_ arr: [T], _ match: V, _ method:@escaping (T, V) -> Bool) -> T? where V: Equatable {
       return arr.first { method($0, match) } // New upgrade, more functional 🤖
    }
    /**
     * Returns the first occurence of an PARAM: match in PARAM: arr that meets PARAM: condition
     * - NOTE: Think of this method as "a conditional indexOf method"
     * - NOTE: the great thing about this method is that your types doesn't need to extend equatable. As not all types needs to be equatable
     * ## EXAMPLES: [("a",0),("x",1),("b",0),("b",1),("c",2)].first(("b",1), {$0.1 == $1.1 && $0.0 == $1.0})//("b", 1)
     */
    public static func first<T>(_ arr: [T], _ match: T, _ condition: (_ a: T, _ b: T) -> Bool) -> T? {
        return arr.first { condition($0, match) }
    }
    /**
     * Returns a random array with unique numbers (no duplicates)
     * ## EXAMPLES:
     * let ranArr = ArrayParser.uniqueRandom(0, 4)
     * print(ranArr)//[3, 1, 0, 4, 2]
     * - NOTE: There is also IntParser.random
     * - Fixme: ⚠️️ Use functional programming or write an example that utilizes functional programming
     */
    public static func uniqueRandom(_ min: Int, _ max: Int) -> [Int] {
        var numbers: [Int] = []
        for a in min...max { numbers.append(a) }
        var randomNumbers: [Int] = []
        let len: Int = numbers.count
        for e in 0..<len {
            let randomNr: Int = .random(in: 0..<(len - e))//Int(arc4random_uniform(UInt32(len - e)))
            randomNumbers.append(numbers[randomNr])
            _ = numbers.splice2(randomNr, 1)
        }
        return randomNumbers
    }
    /**
     * - IMPORTANT: ⚠️️ Compares reference not value. If value comparing is needed then create another method to support that
     */
    public static func occurences<T>(_ theList: [T], theItem: T) {
        var counter: Int = 0
        theList.forEach {
            if $0 as AnyObject === (theItem as AnyObject) { counter += 1 }
        }
    }
    /**
     * Loops over the array 1 time. Can return different Type than Array type
     * ## EXAMPLES:
     * [("a","1"),("b","2")].mapReduce(""){$0 + ($1.0 + $1.1)}//Output: a1b2
     * - IMPORTANT: ⚠️️ You can also use: arr.lazy.map{}.reduce(){} which does the same thing. Only difference is mapReduce uses 1 closure and the other uses 2. The lazy way may be more appropriate since more people will understand it straight away
     */
    public static func mapReduce<T, V, U>(_ arr: [T], _ initVal: V, _ closure:@escaping (_ interim: V, _ item: T) -> V) -> U {
        var retVal = initVal
        arr.forEach {
            retVal = closure(retVal, $0)
        }
        return retVal as! U
    }
    /**
     * Array.range(from:1,to:4)//1,2,3
     * - IMPORTANT ⚠️️ : Includes the to value but does not include the final to value
     */
    public static func range(from: Int, to: Int) -> [Int] {
        return Array(from..<to)//().map { $0 }
    }
    /**
     * - Important ⚠️️ Swift 4.1 has array.randomElement()
     */
    public static func randomItem<T>(array: [T]) -> T? {
      if array.isEmpty { return nil }
      let index = Int.random(in: 0..<array.count)//Int(arc4random_uniform(UInt32(array.count)))
      return array[index]
   }
}
private class Utils {
    /**
     * Returns the index of the item in PARAM: sortedArray that meets the PARAM: condition method "true", if there is no item in the PARAM sortedArray meets the condition method "true" then return -1 (-1 means no match found)
     */
   static func index<T>(_ value: T, _ sortedArray: [T], _ condition: (_ a: T, _ b: T) -> Bool) -> Int {
        for i in 0..<sortedArray.count {
            if condition(value, sortedArray[i]) { return i }
        }
        return -1
    }
}

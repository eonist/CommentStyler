import Foundation

public class AdvanceArrayModifier {
    /**
     * - NOTE: the index is returned for convenience
     */
    public static func incrementLast(_ index: [Int]) -> [Int] {
        var index = index
        index[index.count - 1] = index[index.count - 1] + 1
        return index
    }
    /**
     * - NOTE: the index is returned for convenience
     */
    public static func incrementLastBy(_ index: [Int], _ integer: Int) -> [Int] {
        var index = index
        index[index.count - 1] = index[index.count - 1] + integer
        return index
    }
    /**
     * I think this method sorts each node in an array-tree to highest index like [[1,0][0,1]] -> [[0,1],[1,0]]  (<---I'm not sure if this example is correct)
     * - NOTE: This method can't sort arrays which are partial, all indecies must exist from 0 to the end etc (It probably can sort partial arrays, but that requires the addAt method to support adding items to lengths that are beyond the length of the array, To add this support you need to make test to make sure its fail safe)
     * - NOTE: see the MDTaskSorter project for how to use this method
     * ## EXAMPLES: let arr6:Array<[Int]> = [[1,0],[0,1]]; let res = AdvanceArrayModifier.sortToHighestDepths(arr6); let toMatch = [[0,1],[0,1]]; res.first! == toMatch.first! && res.last! == toMatch.last! ? print("works") : print("doesn't work")
     * - IMPORTANT: ⚠️️ I Think this method is out of order
     */
    public static func sortToHighestDepths(_ indices: [[Int]]) -> [[Int]] {
        var sortedIndices: [[Int]] = []
        let numOfindices: Int = indices.count
        for i in 0..<numOfindices {
            let index: [Int] = indices[i]
            let indicesIndex: Int = AdvanceArrayParser.index(index, indices)
            ArrayModifier.addAt(&sortedIndices, index, indicesIndex)
        }
        return sortedIndices
    }
    /**
    * Scales an array in both x and y axis
    * - Discussion: Great for scaling an image with pixel perfection
    * ## Examples:
    * Swift.print(scaleArr(arr: [0, 1, 1, 0], size: (width: 2, height: 2), scale:2))// [0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0]
    * Swift.print(scaleArr(arr: [0, 0, 0, 1, 0, 1, 0, 0, 0], size: (width: 3, height: 3), scale: 2)) // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    */
   public static func scaleArr(arr: [Int], size:(width: Int, height: Int), scale: Int) -> [Int] {
      return (0..<size.width * 2).flatMap { x in
         (0..<size.height * 2).map { y in
            let i = x / 2 * size.width + y / 2
            let item: Int = arr[i]
            return item
         }
      }
   }
}

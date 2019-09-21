import Foundation
/**
 * EXAMPLE: Range(start:2,end:6).count//4
 */
extension Range {
    /**
     * ## EXAMPLES: Range<Int>(0,3).numOfIndecies() // 4 -> because [0,1,2,3].count// 4
     * - NOTE: only works with Range<Int> for now
     */
    public init(_ start: Bound, _ end: Bound) { // Conveninence initializer
        //Fixme:  try ->return self.indices.count or self.underestimateCount()
      Swift.print("RangeExtension.init coud be broken in 4.2 ⚠️️")
      self.init(uncheckedBounds: ((start, end)))///*<-CountableRange<Int>*/ //which->converts to Range<Int
      //self.init(start..<end, end)<
    }
    public var start: Bound { return self.lowerBound }//(0..<4).lowerBound -> 0
    public var end: Bound { return self.upperBound }//(0..<4).upperBound -> 4
    /**
     * ⚠️️ string.distance(from: range.lowerBound, to: range.upperBound) should replace the bellow, test it first
     */
    public var length: Int { return (self.upperBound as! Int) - (self.lowerBound as! Int) }/*convenince*/
    public var numOfIndecies: Int { return length + 1 }
}
extension CountableRange/* where Bound:Integer */{
    public var start: Bound { return self.startIndex }/*convenince*/
    public var end: Bound { return self.endIndex }/*convenince*/
    //you can also use the native var: .count instead of the bellow .length
    public var length: Int { return (self.endIndex as! Int) - (self.startIndex as! Int) }/*convenince*/
    public var numOfIndecies: Int { return (self.end as! Int) - (self.start as! Int) + 1 }//Fixme: rewrite this as: length + 1
    public var random: Int {
      let max = self.end as! Int
      let min = self.start as! Int
      let random = Int.random(in: min..<max)//Int(arc4random_uniform(UInt32(max)) + UInt32(min))
      return random
   }
}
extension Range {
    public func equals(_ range: Range<Bound>) -> Bool {/*Convenience*/
        return RangeAsserter.equals(self, range)
    }
    public func within(_ number: Bound) -> Bool {/*Convenience*/
        return RangeAsserter.within(self, number)
    }
    public func contained(_ number: Bound) -> Bool {/*Convenience*/
        return RangeAsserter.contained(self, number)
    }
    public func overlaps(_ range: Range<Bound>) -> Bool {/*Convenience*/
        return RangeAsserter.overlaps(self, range)
    }
    public func contains(_ range: Range<Bound>) -> Bool {/*Convenience*/
        return RangeAsserter.contains(self, range)
    }
    public func edge(_ index: Bound) -> Bool {/*Convenience*/
        return RangeAsserter.edge(index, self)
    }
}

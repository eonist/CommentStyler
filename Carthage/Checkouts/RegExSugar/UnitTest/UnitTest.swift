import XCTest
import RegExSugar

class UnitTest: XCTestCase {
   override func setUp() {
      super.setUp()
   }
   override func tearDown() {
      super.tearDown()
   }
   func testExample() {
      testRemoveComments()
      testReplace()
      testMatches()
   }
//   func testPerformanceExample() {
////      self.measure { }
//   }
}
extension UnitTest {
   /**
    * testRemoveComments
    */
   private func testRemoveComments() {
      let str: String = "P{color:#00FF00;}/*Paragraph color*/"
      let strSansComment: String = RegExpModifier.removeComments(str)
      XCTAssertEqual(strSansComment, "P{color:#00FF00;}")
   }
   /**
    * testReplace
    */
   private func testReplace() {
      let string = "blue:0000FF green:00FF00 red:FF0000"
      let ptrn: String = "(\\w+?)\\:([A-Z0-9]+?)(?: |$)"
      let theResult: String = string.replace(pattern: ptrn) { result in
         let beginning = result.range(at: 1) // Capturing group 1
         let newBegginingStr: String = { // Manipulate the string a bit
            let theStr: String = (string as NSString).substring(with: beginning) as String
            return theStr.uppercased()
         }()
         let end = result.range(at: 2) // Capturing group 2
         let newEndStr: String = (string as NSString).substring(with: end) as String // Keep the same string
         return [(beginning, newBegginingStr), (end, newEndStr)]
      }
      Swift.print("theResult:  \(theResult)") // BLUE:0000FF GREEN:00FF00 RED:FF0000
      XCTAssertEqual(theResult, "BLUE:0000FF GREEN:00FF00 RED:FF0000")
   }
   /**
    * testMatches
    */
   private func testMatches() {
      let str = "blue:0000FF green:00FF00 red:FF0000"
      let pattern = "(\\w+?)\\:([A-Z0-9]+?)(?: |$)"
      let matches: [String] = str.matches(pattern: pattern) { $0.value(str, key: 2) } // 0000FF, 00FF00, FF0000
      Swift.print("matches:  \(matches)") //  ["0000FF", "00FF00", "FF0000"]
      XCTAssertEqual(matches, ["0000FF", "00FF00", "FF0000"])
   }
}

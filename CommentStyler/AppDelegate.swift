import UIKit
import RegExSugar
import ArraySugarIOS
import StringSugar
/**
 * - Note: Alternative name? Comment-linter
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   lazy var window: UIWindow? = {
      let win = UIWindow(frame: UIScreen.main.bounds)
      let vc = MainVC()
      win.rootViewController = vc
      win.makeKeyAndVisible()/*Important since we have no Main storyboard anymore*/
      return win
   }()
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      _ = window
      return true
   }
}
class MainVC: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      view = MainView()
      view.backgroundColor = .orange
   }
   override var prefersStatusBarHidden: Bool { return false }
}
class MainView: UIView {
   override init(frame: CGRect) {
      super.init(frame: frame)
//      test1()
//      test2()
      test3()
//      test4()
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
extension MainView {
   /**
    *
    */
   func test4() {
      let testStr: String = "abc 💪✅🎉✅🚫✅✅✅✅44"
      let theMatch: [String] = testStr.matches(pattern: "^(.*?$)") {
         return $0.rangeAndString(testStr, key: 1).match
      }
      Swift.print("theMatch:  \(theMatch)")
   }
   /**
    * Test3
    */
   func test3() {
      let testStr = """
                        func test1() {}
                        /**
                         * Changes a string to ASCII representation ✅💪🎉🎉🎉⚠️️
                         * - Parameter input: the string input ✅
                         * - Parameter closure: the edit closure 🚫
                         * - Fixme: ⚠️️ Needs refactoring 🎉
                         */
                        func test2() { var a = 1 }
                        /**
                         * Another comment
                         */
                        func test3() { var b = 2 }
                     """
      let pattern: String = {
         let opening: String = "(\\/\\*\\*)" + "(?:\\s*?)" // aka: /** + whitespace
         let middle: String = "((?:.|\\s)*?)"
         let closing: String = "(?:\\s*?)" + "(\\*\\/)" // aka: whitespace + */
         return /*"^" + */opening + middle + closing/* + "$"*/
      }()
      let theResult: String = RegExp.replace(str: testStr, pattern: pattern) { result in
         let start = result.nsRangeAndString(testStr, key: 1)
         let mid = result.nsRangeAndString(testStr, key: 2)
         let lines: [String] = mid.match.split(separator: "\n").map { String($0) }
         let midStr: String = "\n" + lines.reversed().map { line in
            line.replace(pattern: "(\\*)") { [($0.range(at: 1), "///")] }
         }.reversed().joined(separator: "\n")
         let end = result.nsRangeAndString(testStr, key: 3)
         return [(start.range, " ///"), (mid.range, midStr), (end.range, "///")]
      }
      Swift.print("theResult:  \(theResult)")
      
      // make mac app 👈
         // convert comment-block in selection { ctrl + shift + 8 }
      // find copy paste snippet ✅
      // find statusbar snippet ✅
   }
   /**
    * Test1
    */
   func test1() {
      let test = """
                     abca
                     /**
                        * abc
                     * dgf
                     */
                  """
//      let test: String = "xyz/**abc*/"
      let pattern: String = {
         let opening: String = "(\\/\\*\\*)" + "(?:\\s*?)" // aka: /** + whitespace
         let middle: String = "((?:.|\\s)*?)"
         let closing: String = "(?:\\s*?)" + "(\\*\\/)" // aka: whitespace + */
         return /*"^" + */opening + middle + closing/* + "$"*/
      }()

      let matches: [(start: String, mid: String, end: String)] = test.matches(pattern: pattern) {
         let start = $0.value(test, key: 1)
         let mid = $0.value(test, key: 2)
         let end = $0.value(test, key: 3)
         return (start, mid, end)
      }
      Swift.print("matches:  \(matches)")
      
      matches.forEach { string in
         Swift.print("string.start:  \(string.start)")
         let lines = string.mid.split(separator: "\n")
         lines.map { String($0) }.forEach { line in
            Swift.print("line:  >\(line)< match:  \(line.matches(pattern: "(\\*)") { $0.value(line, key: 1) } )")
         }
         Swift.print("string.end:  \(string.end)")
      }
      
   }
   
   /**
    * Test2 🎉
    */
   func test2() {
//      let string = "blue:0000FF green:00FF00 red:FF0000"
//      let ptrn: String = "(\\w+?)\\:([A-Z0-9]+?)(?: |$)"
//      let theResult: String = RegExp.replace(str: string, pattern: ptrn) { result in
//         let beginning = result.stringRange(string, key: 1) // Capturing group 1
//         let newBegginingStr: String = { // Manipulate the string a bit
//            let theStr: String = .init(string[beginning])
//            return theStr.uppercased()
//         }()
//         let end = result.stringRange(string, key: 2) // Capturing group 2
//         let newEndStr: String = .init(string[end]) // Keep the same string
//         return [(beginning, newBegginingStr), (end, newEndStr)]
//      }
//      Swift.print("theResult:  \(theResult)") //BLUE:0000FF GREEN:00FF00 RED:FF0000
   }
}
//    fatalError("\(test.test(pattern))")
// Find comment block
// Find and Remove /** and add ///
//    (begining)(middle)(end)
// Loop through each line from 1..count -1 remove *
// Find and remove */ Add ///

//      let result = RegExp.matches(str, pattern: "(\\w+?)\\:([A-Z0-9]+?)(?: |$)").forEach { result in // NSTextCheckingResult
//         Swift.print("result")
//         let checkingResult: NSTextCheckingResult = result
//         Swift.print("match.numberOfRanges: " + "\(result.numberOfRanges)") // The first item is the entire match
//         let content: String = (str as NSString).substring(with: result.range(at: 0)) // The entire match
//         let name: String = result.value(str, key: 1) // Capturing group 1
//         let value: String = result.value(str, key: 2) // Capturing group 2
//         Swift.print("content: \(content) name:  \(name) value:  \(value)")
//      }

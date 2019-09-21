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
      test1()
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
extension MainView {
   func test1() {
      let test: String = "abca/**abc*/"
      let pattern: String = {
         let opening: String = "\\/\\*\\*" // aka: /**
         let closing: String = "\\*\\/" // aka: */
         return /*"^" + */opening + ".*?" + closing/* + "$"*/
      }()
      print(test.test(pattern))
      let idx: Int? = test.search(pattern)
      Swift.print("idx:  \(idx)")
//      fatalError("\(test.test(pattern))")
      // Find comment block
      // Find and Remove /** and add ///
      // Loop through each line from 1..count -1 remove *
      // Find and remove */ Add ///
   }
}

import Cocoa
import ClipboardSugar_macOS
import RegExSugarMacOS

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
   @IBOutlet weak var window: NSWindow!
   var statusBar = NSStatusBar.system
   var statusBarItem : NSStatusItem = NSStatusItem()
   var menu: NSMenu = NSMenu()
   var menuItem : NSMenuItem = NSMenuItem()
   /**
    * - Fixme: ⚠️️ use With
    */
   func applicationDidFinishLaunching(_ aNotification: Notification) {
      Swift.print("applicationDidFinishLaunching")
      window.close()
      
      //Add statusBarItem
      statusBarItem = statusBar.statusItem(withLength: -1)
      statusBarItem.menu = menu
      statusBarItem.button?.title = "Comment-styler"
      statusBarItem.button?.cell?.isHighlighted = false
      
      //Add menuItem to menu
      menuItem.title = "Convert comment-block"
      menuItem.action = #selector(applyStyling)
//      menuItem.keyEquivalent = "" //  ctrl + shift + 8
//      menuItem.keyEquivalent = "b"
//      menuItem.keyEquivalentModifierMask = .init(arrayLiteral: .control) // .control.rawValue | NSEvent.ModifierFlags.option.rawValue | NSEvent.ModifierFlags.command.rawValue
      menu.addItem(menuItem)
      
      let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "")
      menu.addItem(quitMenuItem)
   }
}
/**
 * Events
 */
extension AppDelegate {
   @objc func quitApp(){
      NSApplication.shared.terminate(self)
   }
   /**
    * Apply styling
    */
   @objc func applyStyling(sender: AnyObject){
      Utils.copySelectedText()
      Utils.pauseForAMoment() // so that the copy selected text operation can finish
      guard let clipboardText:String = ClipboardParser.getString() else { Swift.print("⚠️️ didn't work ⚠️️"); return }
      let convertedString: String = convert(str: clipboardText)
      ClipboardModifier.setString(string: convertedString)
      Utils.pasteSelectedText()
   }
}
/**
 * Helper
 */
extension AppDelegate {
   static let pattern: String = {
      let opening: String = "(\\/\\*\\*)" + "(?:\\s*?)" // aka: /** + whitespace
      let middle: String = "((?:.|\\s)*?)"
      let closing: String = "(?:\\s*?)" + "(\\*\\/)" // aka: whitespace + */
      return opening + middle + closing
   }()
   /**
    * Converts /***/ to /// etc
    */
   func convert(str: String) -> String{
      return RegExp.replace(str: str, pattern: AppDelegate.pattern) { result in
         let start = result.nsRangeAndString(str, key: 1)
         let mid = result.nsRangeAndString(str, key: 2)
         let midStr: String = {
            let lines: [String] = mid.match.split(separator: "\n").map { String($0) }
            return "\n" + lines.reversed().map { line in
               line.replace(pattern: "(\\*)") { [($0.range(at: 1), "///")] }
               }.reversed().joined(separator: "\n")
         }()
         let end = result.nsRangeAndString(str, key: 3)
         return [(start.range, " ///"), (mid.range, midStr), (end.range, "///")]
      }
   }
}

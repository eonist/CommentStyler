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
   var menuItem2 : NSMenuItem = NSMenuItem()
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
      menuItem.action = #selector(convertCommentBlock)
//      menuItem.keyEquivalent = "" //  ctrl + shift + 8
//      menuItem.keyEquivalent = "b"
//      menuItem.keyEquivalentModifierMask = .init(arrayLiteral: .control) // .control.rawValue | NSEvent.ModifierFlags.option.rawValue | NSEvent.ModifierFlags.command.rawValue
      menu.addItem(menuItem)
      
      menuItem2.title = "Consolidate parameters"
      menuItem2.action = #selector(doConsolidateParameters)
      menu.addItem(menuItem2)
      
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
   @objc func convertCommentBlock(sender: AnyObject){
      Utils.copySelectedText()
      Utils.pauseForAMoment() // so that the copy selected text operation can finish
      guard let clipboardText: String = ClipboardParser.getString() else { Swift.print("⚠️️ didn't work ⚠️️"); return }
      let convertedString: String = convertCommentBlockString(str: clipboardText)
      ClipboardModifier.setString(string: convertedString)
      Utils.pasteSelectedText()
   }
   /**
    * Consolidate parameters
    */
   @objc func doConsolidateParameters(sender: AnyObject){
      Utils.copySelectedText()
      Utils.pauseForAMoment() // so that the copy selected text operation can finish
      guard let clipboardText: String = ClipboardParser.getString() else { Swift.print("⚠️️ didn't work ⚠️️"); return }
      let convertedString: String = consolidateParameters(str: clipboardText)
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
   func convertCommentBlockString(str: String) -> String{
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
extension AppDelegate{
   static let consolidationPattern: String = {
      let prefix = "^\\s*?\\*\\s\\-\\s" + "Parameter" + "\\s"
      let title = "(.*?)" + "\\:\\s"
      let desc = "(.*?)$"
      return prefix + title + desc
   }()
   /**
    * Consolidates parameters
    */
   func consolidateParameters(str: String) -> String {
      return RegExp.replace(str: str, pattern: "(.|\\n)+") { result in
         let midStr: String = {
            let lines: [String] = str.split(separator: "\n").map { String($0) }
            return "\n" + lines.reversed().map { line in
               line.replace(pattern: AppDelegate.consolidationPattern) {
                  let title = $0.value(line, key: 1)
                  let desc = $0.value(line, key: 2)
                  return [($0.range(at: 0), " *   - \(title): " + "\(desc)")]
               }
               }.reversed().joined(separator: "\n")
         }()
         return [(NSRange.init(location: 0, length: 0), " * - Parameters:"), (result.range(at: 0), midStr) ]
      }
   }
}

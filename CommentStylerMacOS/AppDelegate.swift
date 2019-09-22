import Cocoa
import ClipboardSugar_macOS
import RegExSugarMacOS
import ArraySugarMacOS
import StringSugarMacOS

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
      menuItem.keyEquivalent = "" //  ctrl + shift + 8
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
//      Swift.print("quitApp")
      NSApplication.shared.terminate(self)
   }
   /**
    * Apply styling
    */
   @objc func applyStyling(sender: AnyObject){
//      Swift.print("applyStyling")
      Utils.copySelectedText()
      Utils.pauseForAMoment()//so that the copy selected text operation can finish
      guard let clipboardText:String = ClipboardParser.getString() else { Swift.print("⚠️️ didn't work ⚠️️"); return }
//      Swift.print("clipboardText:  \(clipboardText)")
      let convertedString: String = convert(str: clipboardText)
//      Swift.print("convertedString:  \(convertedString)")
      ClipboardModifier.setString(string: convertedString)
      Utils.pasteSelectedText()
   }
   
}
/**
 * Helper code to manipulate selected string
 */
private class Utils{
   /**
    * x = 0x07 (if you want to do cut instead of copy)
    */
   static func copySelectedText(){
//      Swift.print("copySelectedText")
      let src:CGEventSource = CGEventSource(stateID: CGEventSourceStateID(rawValue: CGEventSourceStateID.hidSystemState.rawValue/*kCGEventSourceStateHIDSystemState*/)!)!
      
      let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)//0x08 is the "cmd" char
      let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)
      let ccd = CGEvent(keyboardEventSource: src, virtualKey: 0x08, keyDown: true)//0x08 is the "c" char
      let ccu = CGEvent(keyboardEventSource: src, virtualKey: 0x08, keyDown: false)
      
      ccd?.flags = CGEventFlags.maskCommand//CGEventSetFlags(ccd, CGEventFlags(rawValue: CGEventFlags.maskCommand.rawValue));/*kCGEventFlagMaskCommand*/
      ccu?.flags = CGEventFlags.maskCommand//CGEventSetFlags(ccu, CGEventFlags(rawValue: CGEventFlags.maskCommand.rawValue));/*kCGEventFlagMaskCommand*/
      
      let loc:CGEventTapLocation = CGEventTapLocation(rawValue: CGEventTapLocation.cghidEventTap.rawValue/*kCGHIDEventTap*/)!
      
      cmdd?.post(tap: loc)//CGEventPost(loc, cmdd)
      ccd?.post(tap: loc)//CGEventPost(loc, ccd)
      ccu?.post(tap: loc)//CGEventPost(loc, ccu)
      cmdu?.post(tap: loc)//CGEventPost(loc, cmdu)
   }
   /**
    *
    */
   static func pasteSelectedText(){
//      Swift.print("pasteSelectedText")
      let src:CGEventSource = CGEventSource(stateID: CGEventSourceStateID(rawValue: CGEventSourceStateID.hidSystemState.rawValue/*kCGEventSourceStateHIDSystemState*/)!)!
      
      let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)//0x08 is the "cmd" char
      let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)
      let ccd = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)//0x09 is the "v" char
      let ccu = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
      
      ccd?.flags = CGEventFlags.maskCommand//CGEventSetFlags(ccd, CGEventFlags(rawValue: CGEventFlags.maskCommand.rawValue));/*kCGEventFlagMaskCommand*/
      ccu?.flags = CGEventFlags.maskCommand//CGEventSetFlags(ccu, CGEventFlags(rawValue: CGEventFlags.maskCommand.rawValue));/*kCGEventFlagMaskCommand*/
      
      let loc:CGEventTapLocation = CGEventTapLocation(rawValue: CGEventTapLocation.cghidEventTap.rawValue/*kCGHIDEventTap*/)!
      
      cmdd?.post(tap: loc)//CGEventPost(loc, cmdd)
      ccd?.post(tap: loc)//CGEventPost(loc, ccd)
      ccu?.post(tap: loc)//CGEventPost(loc, ccu)
      cmdu?.post(tap: loc)//CGEventPost(loc, cmdu)
   }
   /**
    * pause method
    */
   static func pauseForAMoment() {
      sleep(1)
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
      return /*"^" + */opening + middle + closing/* + "$"*/
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

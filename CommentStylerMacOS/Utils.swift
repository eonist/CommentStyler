import Foundation
/**
 * Helper code to manipulate selected string
 */
class Utils{
   /**
    * x = 0x07 (if you want to do cut instead of copy)
    */
   static func copySelectedText(){
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
    * Paste
    */
   static func pasteSelectedText(){
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

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
   @IBOutlet weak var window: NSWindow!
   var statusBar = NSStatusBar.system
   var statusBarItem : NSStatusItem = NSStatusItem()
   var menu: NSMenu = NSMenu()
   var menuItem : NSMenuItem = NSMenuItem()

   func applicationDidFinishLaunching(_ aNotification: Notification) {
//      _ = view
      Swift.print("applicationDidFinishLaunching")
      window.close()
      //Add statusBarItem
      statusBarItem = statusBar.statusItem(withLength: -1)
      statusBarItem.menu = menu
      statusBarItem.title = "MDHelper"
      statusBarItem.highlightMode = true
      
      //Add menuItem to menu
      menuItem.title = "Sort tasks"
      menuItem.action = #selector(sortSelectedTasks)
      menuItem.keyEquivalent = ""
      menu.addItem(menuItem)
      
      
      let indexSelectedFilesMenuItem = NSMenuItem(title: "Index files", action: #selector(indexSelectedFiles), keyEquivalent: "")
      menu.addItem(indexSelectedFilesMenuItem)
      
      let seperatorMenuItem = NSMenuItem.separator()
      menu.addItem(seperatorMenuItem)
      
      let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "")
      menu.addItem(quitMenuItem)
   }
   @objc func sortSelectedTasks(sender: AnyObject){
      Swift.print("sortSelectedTasks")
   }
   @objc func indexSelectedFiles(sender: AnyObject){
      Swift.print("indexSelectedFiles")
   }
   @objc func quitApp(){
      Swift.print("quitApp")
   }

}



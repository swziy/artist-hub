import UIKit

let delegateClass = NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, delegateClass)

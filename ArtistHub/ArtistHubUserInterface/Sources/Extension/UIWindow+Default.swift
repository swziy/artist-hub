import UIKit

public extension UIWindow {

    static var `default`: UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()

        return window
    }
}

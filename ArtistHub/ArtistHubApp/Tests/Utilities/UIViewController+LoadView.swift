import UIKit

extension UIViewController {

    func loadView<T: UIView>(_ viewType: T.Type) -> T {
        let typedView = view as! T
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self
        window.makeKeyAndVisible()

        return typedView
    }
}

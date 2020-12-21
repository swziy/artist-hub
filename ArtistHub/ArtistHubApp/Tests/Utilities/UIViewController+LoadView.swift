import UIKit

extension UIViewController {

    func loadView<T: UIView>(_ viewType: T.Type) -> T {
        view as! T
    }
}

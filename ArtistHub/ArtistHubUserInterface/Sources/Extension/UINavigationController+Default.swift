import UIKit

public extension UINavigationController {

    static var `default`: UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}

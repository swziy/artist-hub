import UIKit

class NavigationControllerSpy: UINavigationController {

    private(set) var invokedPushViewController: [(viewController: UIViewController, animated: Bool)] = []
    private var storedViewControllers: [UIViewController] = []

    override var viewControllers: [UIViewController] {
        get {
            storedViewControllers
        }
        set {
            storedViewControllers = newValue
        }
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        invokedPushViewController.append((viewController: viewController, animated: animated))
        storedViewControllers.append(viewController)
    }
}

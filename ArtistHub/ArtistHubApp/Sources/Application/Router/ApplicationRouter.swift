import UIKit

final class ApplicationRouter: ApplicationRouterType {

    private let navigationController: UINavigationController

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - ApplicationRouterType

    func routeToMainScreen(in window: UIWindow) {
        window.rootViewController = navigationController
    }
}

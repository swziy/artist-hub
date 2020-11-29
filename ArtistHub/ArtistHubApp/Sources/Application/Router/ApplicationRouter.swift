import UIKit

final class ApplicationRouter: ApplicationRouterType {

    private var listRouter: ListRouterType?
    private let navigationController: UINavigationController
    private let listRouterFactory: ListRouterFactoryType

    // MARK: - Initialization

    init(navigationController: UINavigationController, listRouterFactory: ListRouterFactoryType) {
        self.navigationController = navigationController
        self.listRouterFactory = listRouterFactory
    }

    // MARK: - ApplicationRouterType

    func routeToMainScreen(in window: UIWindow) {
        window.rootViewController = navigationController

        listRouter = listRouterFactory.makeListRouter()
        listRouter?.routeToListScreen(in: navigationController)
    }
}

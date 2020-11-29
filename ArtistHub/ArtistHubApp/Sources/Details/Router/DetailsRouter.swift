import UIKit

final class DetailsRouter: DetailsRouterType {

    private let controllerFactory: DetailsControllerFactoryType

    init(controllerFactory: DetailsControllerFactoryType) {
        self.controllerFactory = controllerFactory
    }

    // MARK: - DetailsRouterType

    func routeToDetailsScreen(in navigationController: UINavigationController) {
        let controller = controllerFactory.makeDetailsController()
        navigationController.pushViewController(controller, animated: true)
    }
}

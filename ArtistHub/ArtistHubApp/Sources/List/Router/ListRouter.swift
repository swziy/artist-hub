import UIKit

final class ListRouter: ListRouterType {

    private weak var navigationController: UINavigationController?
    private var detailsRouter: DetailsRouterType?
    private let detailsRouterFactory: DetailsRouterFactoryType
    private let controllerFactory: ListControllerFactoryType

    init(controllerFactory: ListControllerFactoryType, detailsRouterFactory: DetailsRouterFactoryType) {
        self.controllerFactory = controllerFactory
        self.detailsRouterFactory = detailsRouterFactory
    }

    // MARK: - ListRouterType

    func routeToListScreen(in navigationController: UINavigationController) {
        self.navigationController = navigationController

        let controller = controllerFactory.makeListController()
        controller.delegate = self

        navigationController.viewControllers = [controller]
    }
}

extension ListRouter: ListViewControllerDelegate {

    // MARK: - ListViewControllerDelegate

    func didSelectDetail(with id: String) {
        guard !id.isEmpty else {
            return
        }

        guard let navigationController = navigationController else {
            return
        }

        detailsRouter = detailsRouterFactory.makeDetailsRouter()
        detailsRouter?.routeToDetailsScreen(in: navigationController)
    }
}

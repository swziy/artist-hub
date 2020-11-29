import UIKit
@testable import ArtistHubApp

class DetailsRouterSpy: DetailsRouterType {

    private(set) var invokedNavigateToDetailsScreen: [UINavigationController] = []

    // MARK: - DetailsRouterType

    func routeToDetailsScreen(in navigationController: UINavigationController) {
        invokedNavigateToDetailsScreen.append(navigationController)
    }
}

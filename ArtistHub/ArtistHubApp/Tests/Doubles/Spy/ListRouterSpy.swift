import UIKit
@testable import ArtistHubApp

class ListRouterSpy: ListRouterType {

    private(set) var invokedNavigateToListScreen: [UINavigationController] = []

    // MARK: - ListRouterType

    func routeToListScreen(in navigationController: UINavigationController) {
        invokedNavigateToListScreen.append(navigationController)
    }
}

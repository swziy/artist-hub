@testable import ArtistHubApp

class ListControllerFactorySpy: ListControllerFactoryType {

    var stubbedController = ListViewController()
    private(set) var invokedMakeListController: Int = 0

    // MARK: - ListControllerFactoryType

    func makeListController() -> ListViewController {
        invokedMakeListController += 1
        return stubbedController
    }
}

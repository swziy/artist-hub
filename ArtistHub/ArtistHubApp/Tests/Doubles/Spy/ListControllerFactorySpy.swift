@testable import ArtistHubApp

class ListControllerFactorySpy: ListControllerFactoryType {

    var stubbedController = ListViewController(listViewRepository: ListViewRepositoryStub(), imageManager: ImageManagerSpy())
    private(set) var invokedMakeListController: Int = 0

    // MARK: - ListControllerFactoryType

    func makeListController() -> ListViewControllerType {
        invokedMakeListController += 1
        return stubbedController
    }
}

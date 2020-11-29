@testable import ArtistHubApp

class ListRouterFactorySpy: ListRouterFactoryType {

    var listRouterSpy = ListRouterSpy()
    private(set) var invokedMakeListRouter: Int = 0

    // MARK: - ListRouterFactoryType

    func makeListRouter() -> ListRouterType {
        invokedMakeListRouter += 1
        return listRouterSpy
    }
}

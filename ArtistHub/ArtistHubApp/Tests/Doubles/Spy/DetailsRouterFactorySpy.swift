@testable import ArtistHubApp

class DetailsRouterFactorySpy: DetailsRouterFactoryType {

    var detailsRouterSpy = DetailsRouterSpy()
    private(set) var invokedMakeDetailsRouter: Int = 0

    // MARK: - DetailsRouterFactoryType

    func makeDetailsRouter() -> DetailsRouterType {
        invokedMakeDetailsRouter += 1
        return detailsRouterSpy
    }
}

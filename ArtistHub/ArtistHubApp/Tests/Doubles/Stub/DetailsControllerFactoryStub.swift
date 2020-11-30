@testable import ArtistHubApp

class DetailsControllerFactoryStub: DetailsControllerFactoryType {

    var stubbedController: DetailsViewController = DetailsViewController()

    // MARK: - DetailsControllerFactoryType

    func makeDetailsController() -> DetailsViewControllerType {
        stubbedController
    }
}

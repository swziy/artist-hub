import XCTest
@testable import ArtistHubApp

class ListRouterTests: XCTestCase {

    var navigationController: UINavigationController!
    var controllerFactorySpy: ListControllerFactorySpy!
    var detailsRouterFactorySpy: DetailsRouterFactorySpy!
    var sut: ListRouter!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        controllerFactorySpy = ListControllerFactorySpy()
        detailsRouterFactorySpy = DetailsRouterFactorySpy()
        sut = ListRouter(controllerFactory: controllerFactorySpy, detailsRouterFactory: detailsRouterFactorySpy)
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
        controllerFactorySpy = nil
        detailsRouterFactorySpy = nil
        sut = nil
    }

    func test_whenRoutingInvoked_shouldMakeListControllerAndSetupDelegate() {
        sut.routeToListScreen(in: navigationController)

        XCTAssertEqual(controllerFactorySpy.invokedMakeListController, 1)
        XCTAssertTrue(controllerFactorySpy.stubbedController.delegate === sut)
    }

    func test_whenRoutingInvoked_shouldSetViewControllerAsNavigationRoot() {
        sut.routeToListScreen(in: navigationController)

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, controllerFactorySpy.stubbedController)
    }

    func test_whenRoutingInvokedAndRequestedToShowDetailsWithEmptyId_shouldNotNavigateToDetails() {
        sut.routeToListScreen(in: navigationController)
        sut.didSelectDetail(with: "")

        XCTAssertEqual(detailsRouterFactorySpy.invokedMakeDetailsRouter, 0)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.count, 0)
    }

    func test_whenRoutingInvokedAndRequestedToShowDetails_shouldNavigateToDetails() {
        sut.routeToListScreen(in: navigationController)
        sut.didSelectDetail(with: "<test_id>")

        XCTAssertEqual(detailsRouterFactorySpy.invokedMakeDetailsRouter, 1)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.count, 1)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.first, navigationController)
    }

    func test_whenRoutingNotInvokedYet_andRequestedToShowDetails_shouldNotNavigateToDetails() {
        sut.didSelectDetail(with: "<test_id>")

        XCTAssertEqual(detailsRouterFactorySpy.invokedMakeDetailsRouter, 0)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.count, 0)
    }
}

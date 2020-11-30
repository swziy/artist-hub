import XCTest
@testable import ArtistHubApp

class ListRouterTests: XCTestCase {

    var navigationControllerSpy: NavigationControllerSpy!
    var controllerFactorySpy: ListControllerFactorySpy!
    var detailsRouterFactorySpy: DetailsRouterFactorySpy!
    var sut: ListRouter!

    override func setUp() {
        super.setUp()
        navigationControllerSpy = NavigationControllerSpy()
        controllerFactorySpy = ListControllerFactorySpy()
        detailsRouterFactorySpy = DetailsRouterFactorySpy()
        sut = ListRouter(controllerFactory: controllerFactorySpy, detailsRouterFactory: detailsRouterFactorySpy)
    }

    override func tearDown() {
        super.tearDown()
        navigationControllerSpy = nil
        controllerFactorySpy = nil
        detailsRouterFactorySpy = nil
        sut = nil
    }

    func test_whenRoutingInvoked_shouldMakeListControllerAndSetupDelegate() {
        sut.routeToListScreen(in: navigationControllerSpy)

        XCTAssertEqual(controllerFactorySpy.invokedMakeListController, 1)
        XCTAssertTrue(controllerFactorySpy.stubbedController.delegate === sut)
    }

    func test_whenRoutingInvoked_shouldSetViewControllerAsNavigationRoot() {
        sut.routeToListScreen(in: navigationControllerSpy)

        XCTAssertEqual(navigationControllerSpy.viewControllers.count, 1)
        XCTAssertEqual(navigationControllerSpy.viewControllers.first, controllerFactorySpy.stubbedController)
    }

    func test_whenRoutingInvokedAndRequestedToShowDetailsWithEmptyId_shouldNotNavigateToDetails() {
        sut.routeToListScreen(in: navigationControllerSpy)
        sut.didSelectDetail(with: "")

        XCTAssertEqual(detailsRouterFactorySpy.invokedMakeDetailsRouter, 0)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.count, 0)
    }

    func test_whenRoutingInvokedAndRequestedToShowDetails_shouldNavigateToDetails() {
        sut.routeToListScreen(in: navigationControllerSpy)
        sut.didSelectDetail(with: "<test_id>")

        XCTAssertEqual(detailsRouterFactorySpy.invokedMakeDetailsRouter, 1)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.count, 1)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.first, navigationControllerSpy)
    }

    func test_whenRoutingNotInvokedYet_andRequestedToShowDetails_shouldNotNavigateToDetails() {
        sut.didSelectDetail(with: "<test_id>")

        XCTAssertEqual(detailsRouterFactorySpy.invokedMakeDetailsRouter, 0)
        XCTAssertEqual(detailsRouterFactorySpy.detailsRouterSpy.invokedNavigateToDetailsScreen.count, 0)
    }
}

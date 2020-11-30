import XCTest
@testable import ArtistHubApp

class DetailsRouterTests: XCTestCase {

    var navigationControllerSpy: NavigationControllerSpy!
    var controllerFactoryStub: DetailsControllerFactoryStub!
    var sut: DetailsRouter!

    override func setUp() {
        super.setUp()
        navigationControllerSpy = NavigationControllerSpy()
        controllerFactoryStub = DetailsControllerFactoryStub()
        sut = DetailsRouter(controllerFactory: controllerFactoryStub)
    }

    override func tearDown() {
        super.tearDown()
        navigationControllerSpy = nil
        controllerFactoryStub = nil
        sut = nil
    }

    func test_whenRoutingInvoked_shouldPushViewController() {
        sut.routeToDetailsScreen(in: navigationControllerSpy)

        XCTAssertEqual(navigationControllerSpy.invokedPushViewController.count, 1)
        XCTAssertEqual(navigationControllerSpy.viewControllers.count, 1)
        XCTAssertTrue(navigationControllerSpy.viewControllers.first === controllerFactoryStub.stubbedController)
    }
}

import XCTest
@testable import ArtistHubApp

class ApplicationRouterTests: XCTestCase {

    var navigationControllerSpy: NavigationControllerSpy!
    var listRouterFactorySpy: ListRouterFactorySpy!
    var sut: ApplicationRouter!

    override func setUp() {
        super.setUp()
        navigationControllerSpy = NavigationControllerSpy()
        listRouterFactorySpy = ListRouterFactorySpy()
        sut = ApplicationRouter(navigationController: navigationControllerSpy, listRouterFactory: listRouterFactorySpy)
    }

    override func tearDown() {
        super.tearDown()
        navigationControllerSpy = nil
        listRouterFactorySpy = nil
        sut = nil
    }

    func test_whenRoutingInvoked_shouldSetRootViewControllerForWindow() {
        let window = UIWindow()
        sut.routeToMainScreen(in: window)

        XCTAssertEqual(window.rootViewController, navigationControllerSpy)
    }

    func test_whenRoutingInvoked_shouldCreateListRouter() {
        let window = UIWindow()
        sut.routeToMainScreen(in: window)

        XCTAssertEqual(listRouterFactorySpy.invokedMakeListRouter, 1)
    }

    func test_whenRoutingInvoked_routeToListScreen() {
        let window = UIWindow()
        sut.routeToMainScreen(in: window)
        
        XCTAssertEqual(listRouterFactorySpy.listRouterSpy.invokedNavigateToListScreen.count, 1)
        XCTAssertEqual(listRouterFactorySpy.listRouterSpy.invokedNavigateToListScreen.first, navigationControllerSpy)
    }
}

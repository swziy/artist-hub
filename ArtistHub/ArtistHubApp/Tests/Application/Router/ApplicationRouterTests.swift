import XCTest
@testable import ArtistHubApp

class ApplicationRouterTests: XCTestCase {

    var navigationController: UINavigationController!
    var listRouterFactorySpy: ListRouterFactorySpy!
    var sut: ApplicationRouter!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        listRouterFactorySpy = ListRouterFactorySpy()
        sut = ApplicationRouter(navigationController: navigationController, listRouterFactory: listRouterFactorySpy)
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
        listRouterFactorySpy = nil
        sut = nil
    }

    func test_whenRoutingInvoked_shouldSetRootViewControllerForWindow() {
        let window = UIWindow()
        sut.routeToMainScreen(in: window)

        XCTAssertEqual(window.rootViewController, navigationController)
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
        XCTAssertEqual(listRouterFactorySpy.listRouterSpy.invokedNavigateToListScreen.first, navigationController)
    }
}

import XCTest
@testable import ArtistHubApp

class ApplicationRouterTests: XCTestCase {

    var navigationController: UINavigationController!
    var sut: ApplicationRouter!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        sut = ApplicationRouter(navigationController: navigationController)
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
        sut = nil
    }

    func test_whenRoutingInvoked_shouldSetRootViewControllerForWindow() {
        let window = UIWindow()
        sut.routeToMainScreen(in: window)
        XCTAssertEqual(window.rootViewController, navigationController)
    }
}

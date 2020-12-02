import XCTest
@testable import ArtistHubApp

class AppDelegateTests: XCTestCase {

    var navigationBarAppearanceConfiguratorSpy: NavigationBarAppearanceConfiguratorSpy!
    var applicationRouterSpy: ApplicationRouterSpy!
    var sut: AppDelegate!

    override func setUp() {
        super.setUp()
        sut = AppDelegate()
        navigationBarAppearanceConfiguratorSpy = NavigationBarAppearanceConfiguratorSpy()
        applicationRouterSpy = ApplicationRouterSpy()
        sut.router = applicationRouterSpy
        sut.navigationBarAppearanceConfigurator = navigationBarAppearanceConfiguratorSpy
    }

    override func tearDown() {
        super.tearDown()
        navigationBarAppearanceConfiguratorSpy = nil
        applicationRouterSpy = nil
        sut = nil
    }

    func test_whenFinishLaunching_shouldHaveWindow() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

        XCTAssertNotNil(sut.window)
    }

    func test_whenFinishLaunching_shouldRouteToMainScreen() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        XCTAssertEqual(applicationRouterSpy.routeToMainScreenInvoked.count, 1)
    }

    func test_whenFinishLaunching_shouldConfigureNavigationBarAppearance() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

        XCTAssertEqual(navigationBarAppearanceConfiguratorSpy.invokedConfigure, 1)
    }
}

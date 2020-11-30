import XCTest
@testable import ArtistHubApp

class AppDelegateTests: XCTestCase {

    var applicationRouterSpy: ApplicationRouterSpy!
    var sut: AppDelegate!

    override func setUp() {
        super.setUp()
        sut = AppDelegate()
        applicationRouterSpy = ApplicationRouterSpy()
        sut.router = applicationRouterSpy
    }

    override func tearDown() {
        super.tearDown()
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
}

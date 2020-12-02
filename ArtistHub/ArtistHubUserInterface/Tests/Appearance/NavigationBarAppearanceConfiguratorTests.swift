import XCTest
@testable import ArtistHubUserInterface

class NavigationBarAppearanceConfiguratorTests: XCTestCase {

    var sut: NavigationBarAppearanceConfigurator!

    override func setUp() {
        super.setUp()
        sut = NavigationBarAppearanceConfigurator()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenConfigureInvoked_shouldHaveCorrectStandardAppearance() {
        sut.configure()

        let appearance = UINavigationBar.appearance().standardAppearance
        XCTAssertEqual(appearance.backgroundColor, UIColor.Fill.accent)

        XCTAssertEqual(appearance.titleTextAttributes.count, 2)
        XCTAssertEqual(appearance.titleTextAttributes[.foregroundColor] as! UIColor, UIColor.white)

        XCTAssertEqual(appearance.largeTitleTextAttributes.count, 2)
        XCTAssertEqual(appearance.largeTitleTextAttributes[.foregroundColor] as! UIColor, UIColor.systemPink)
    }

    func test_whenConfigureInvoked_shouldHaveCorrectLargeAppearance() {
        sut.configure()

        let appearance = UINavigationBar.appearance().scrollEdgeAppearance!
        XCTAssertEqual(appearance.backgroundColor, UIColor.Fill.lightGray)

        XCTAssertEqual(appearance.titleTextAttributes.count, 2)
        XCTAssertEqual(appearance.titleTextAttributes[.foregroundColor] as! UIColor, UIColor.white)

        XCTAssertEqual(appearance.largeTitleTextAttributes.count, 2)
        XCTAssertEqual(appearance.largeTitleTextAttributes[.foregroundColor] as! UIColor, UIColor.systemPink)
    }
}

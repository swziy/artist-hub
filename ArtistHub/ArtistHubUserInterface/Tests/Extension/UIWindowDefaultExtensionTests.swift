import XCTest
@testable import ArtistHubUserInterface

class UIWindowDefaultExtensionTests: XCTestCase {

    var sut: UIWindow!

    override func setUp() {
        super.setUp()
        sut = UIWindow.default
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_defaultWindow_haveCorrectFrame() {
        XCTAssertEqual(sut.frame, UIScreen.main.bounds)
    }

    func test_defaultWindow_haveCorrectBackground() {
        XCTAssertEqual(sut.backgroundColor, UIColor.white)
    }

    func test_defaultWindow_isKeyAndVisible() {
        XCTAssertTrue(sut.isKeyWindow)
        XCTAssertFalse(sut.isHidden)
    }
}

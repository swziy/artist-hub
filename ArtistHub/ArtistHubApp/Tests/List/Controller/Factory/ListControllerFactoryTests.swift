import XCTest
@testable import ArtistHubApp

class ListControllerFactoryTest: XCTestCase {

    var sut: ListControllerFactory!

    override func setUp() {
        super.setUp()
        sut = ListControllerFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeController_shouldHaveCorrectType() {
        XCTAssertTrue(sut.makeListController() is ListViewController)
    }
}

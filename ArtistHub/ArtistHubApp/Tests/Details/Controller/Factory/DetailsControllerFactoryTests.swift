import XCTest
@testable import ArtistHubApp

class DetailsControllerFactoryTests: XCTestCase {

    var sut: DetailsControllerFactory!

    override func setUp() {
        super.setUp()
        sut = DetailsControllerFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeController_shouldHaveCorrectType() {
        XCTAssertTrue(sut.makeDetailsController() is DetailsViewController)
    }
}

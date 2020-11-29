import XCTest
@testable import ArtistHubApp

class ListRouterFactoryTests: XCTestCase {

    var sut: ListRouterFactory!

    override func setUp() {
        super.setUp()
        sut = ListRouterFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeRouter_shouldHaveCorrectType() {
        XCTAssertTrue(sut.makeListRouter() is ListRouter)
    }
}

import XCTest
@testable import ArtistHubApp

class DetailsRouterFactoryTests: XCTestCase {

    var sut: DetailsRouterFactory!

    override func setUp() {
        super.setUp()
        sut = DetailsRouterFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeRouter_shouldHaveCorrectType() {
        XCTAssertTrue(sut.makeDetailsRouter() is DetailsRouter)
    }
}

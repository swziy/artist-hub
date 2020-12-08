import XCTest
@testable import ArtistHubCore

class ArtistListServiceFactoryTests: XCTestCase {

    var sut: ArtistListServiceFactory!

    override func setUp() {
        super.setUp()
        sut = ArtistListServiceFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeService_shouldHaveCorrectType() {
        let networkClient = sut.makeArtistListService()
        XCTAssertTrue(networkClient is ArtistListService)
    }
}

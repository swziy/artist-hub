import XCTest
@testable import ArtistHubCore

class ImageServiceFactoryTests: XCTestCase {

    var sut: ImageServiceFactory!

    override func setUp() {
        super.setUp()
        sut = ImageServiceFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeImageService_shouldHaveCorrectType() {
        let result = sut.makeImageService()
        XCTAssertTrue(result is ImageService)
    }
}

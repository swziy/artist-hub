import XCTest
@testable import ArtistHubCore

class ImageManagerFactoryTests: XCTestCase {

    var sut: ImageManagerFactory!

    override func setUp() {
        super.setUp()
        sut = ImageManagerFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeImageManager_shouldReturnCorrectType() {
        let result = sut.makeImageManager()
        XCTAssertTrue(result is ImageManager)
    }
}

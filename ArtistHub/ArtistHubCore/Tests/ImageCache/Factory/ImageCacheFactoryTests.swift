import XCTest
@testable import ArtistHubCore

class ImageCacheFactoryTests: XCTestCase {

    var sut: ImageCacheFactory!

    override func setUp() {
        super.setUp()
        sut = ImageCacheFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeImageCache_shouldReturnCorrectType() {
        let result = sut.makeImageCache()
        XCTAssertTrue(result is ImageCache)
    }

    func test_whenMakeMultipleImageCaches_shouldReturnSameInstance() {
        let first = sut.makeImageCache() as! ImageCache
        let second = sut.makeImageCache() as! ImageCache
        XCTAssertTrue(first === second)
    }
}

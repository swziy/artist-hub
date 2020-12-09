import XCTest
@testable import ArtistHubCore

class ImageManagerTests: XCTestCase {

    var imageCacheSpy: ImageCacheSpy!
    var imageServiceSpy: ImageServiceSpy!
    var sut: ImageManager!

    override func setUp() {
        super.setUp()
        imageServiceSpy = ImageServiceSpy()
        imageCacheSpy = ImageCacheSpy()
        sut = ImageManager(imageService: imageServiceSpy, imageCache: imageCacheSpy)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        imageServiceSpy = nil
        imageCacheSpy = nil
    }

    func test_whenImageIsInCache_shouldRetrieveImage() {
        var capturedResult: Result<UIImage, ImageError>!

        let image: UIImage = .testData
        imageCacheSpy.cache["e05a292eb520a224ba14a58d9b00a0f52961672af0384d447c783b22a1aaf24c"] = image

        sut.getImage(for: "<image_url>") { capturedResult = $0 }

        XCTAssertEqual(imageCacheSpy.invokedGetWithKey, ["e05a292eb520a224ba14a58d9b00a0f52961672af0384d447c783b22a1aaf24c"])
        XCTAssertEqual(capturedResult, .success(image))
    }

    func test_whenImageIsNotInCache_shouldFetchImageAndStoreInCache() {
        var capturedResult: Result<UIImage, ImageError>!

        let image: UIImage = .testData
        imageServiceSpy.stubbedResult = .success(image)

        sut.getImage(for: "<some_image_url>") { capturedResult = $0 }

        XCTAssertEqual(imageCacheSpy.invokedGetWithKey, ["a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53"])
        XCTAssertEqual(imageCacheSpy.invokedSetWithKey, ["a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53"])
        XCTAssertEqual(imageCacheSpy.cache.count, 1)
        XCTAssertEqual(capturedResult, .success(image))
    }

    func test_whenCurrentDownloadIsInProgress_shouldContinuePreviousTask() {
        var firstResult: Result<UIImage, ImageError>?
        var secondResult: Result<UIImage, ImageError>?

        let image: UIImage = .testData
        imageServiceSpy.stubbedResult = .success(image)

        imageServiceSpy.shouldInvokeCompletion = false
        sut.getImage(for: "<some_image_url>") { firstResult = $0 }

        imageServiceSpy.shouldInvokeCompletion = true
        sut.getImage(for: "<some_image_url>") { secondResult = $0 }

        XCTAssertEqual(imageCacheSpy.invokedGetWithKey, [
            "a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53",
            "a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53",
        ])
        XCTAssertEqual(imageCacheSpy.cache.count, 0)
        XCTAssertEqual(firstResult, nil)
        XCTAssertEqual(secondResult, nil)
    }

    func test_whenNetworkErrorOccurs_shouldPassErrorUp() {
        var firstResult: Result<UIImage, ImageError>?

        imageServiceSpy.stubbedResult = .failure(.downloadError)
        sut.getImage(for: "<some_image_url>") { firstResult = $0 }

        XCTAssertEqual(imageCacheSpy.invokedGetWithKey, [
            "a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53",
        ])
        XCTAssertEqual(imageCacheSpy.cache.count, 0)
        XCTAssertEqual(firstResult, .failure(.downloadError))
    }

    func test_whenTaskIsActiveAndCancelIsInvoked_shouldRemoveItFromActiveTasks() {
        var firstResult: Result<UIImage, ImageError>?
        var secondResult: Result<UIImage, ImageError>?

        let image: UIImage = .testData
        imageServiceSpy.stubbedResult = .success(image)

        imageServiceSpy.shouldInvokeCompletion = false
        sut.getImage(for: "<some_image_url>") { firstResult = $0 }

        imageServiceSpy.shouldInvokeCompletion = true

        sut.cancelImage(for: "<some_image_url>")

        sut.getImage(for: "<some_image_url>") { secondResult = $0 }

        XCTAssertEqual(imageCacheSpy.invokedGetWithKey, [
            "a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53",
            "a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53",
        ])

        XCTAssertEqual(imageCacheSpy.invokedSetWithKey, [
            "a758c1778697388f94eccf18a3f3570842500625229394843456fcd521aced53"
        ])
        XCTAssertEqual(imageCacheSpy.cache.count, 1)
        XCTAssertEqual(firstResult, nil)
        XCTAssertEqual(secondResult, .success(image))
    }
}

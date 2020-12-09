import XCTest
import UIKit
@testable import ArtistHubCore

class ImageCacheTests: XCTestCase {

    var sut: ImageCache!

    override func setUp() {
        super.setUp()
        sut = ImageCache.shared
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenRetrieveMissingKey_shouldReturnNoData() {
        let result = sut.image(for: "<non_excising_key>")

        XCTAssertEqual(result, nil)
    }

    func test_whenRetrievePreviouslyStoredKey_shouldReturnNoData() {
        let image = UIImage(named: "vincent", in: .test, with: nil)!
        sut.set(image: image, for: "<vincent_key>")
        let result = sut.image(for: "<vincent_key>")

        XCTAssertEqual(result, image)
    }
}

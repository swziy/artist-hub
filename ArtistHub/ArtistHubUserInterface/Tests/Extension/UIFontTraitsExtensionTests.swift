import XCTest
@testable import ArtistHubUserInterface

class UIFontTraitsExtensionTests: XCTestCase {

    var sut: UIFont!

    override func setUp() {
        super.setUp()
        sut = UIFont.systemFont(ofSize: 16)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_configureWithItalic_shouldHaveCorrectDescriptor() {
        sut = sut.italic
        let descriptor = sut.fontDescriptor
        XCTAssertTrue(descriptor.symbolicTraits.contains(.traitItalic))
    }

    func test_configureWithItalic_shouldHavePreservedSize() {
        sut = sut.italic
        XCTAssertEqual(sut.pointSize, 16.0)
    }

    func test_configureWithBold_shouldHaveCorrectDescriptor() {
        sut = sut.bold
        let descriptor = sut.fontDescriptor
        XCTAssertTrue(descriptor.symbolicTraits.contains(.traitBold))
    }

    func test_configureWithBold_shouldHavePreservedSize() {
        sut = sut.bold
        XCTAssertEqual(sut.pointSize, 16.0)
    }
}

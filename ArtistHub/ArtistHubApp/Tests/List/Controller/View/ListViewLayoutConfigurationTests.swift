import XCTest
@testable import ArtistHubApp

class ListViewLayoutConfigurationTests: XCTestCase {

    var sut: UICollectionViewLayout!

    override func setUp() {
        super.setUp()
        sut = ListViewLayoutConfigurator.makeLayout
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeLayout_shouldBeCompositionalLayout() {
        XCTAssertTrue(sut is UICollectionViewCompositionalLayout)
    }
}

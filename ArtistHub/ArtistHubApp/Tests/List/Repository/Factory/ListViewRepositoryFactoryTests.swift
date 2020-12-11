import XCTest
@testable import ArtistHubApp

class ListViewRepositoryFactoryTests: XCTestCase {

    var sut:ListViewRepositoryFactory!

    override func setUp() {
        super.setUp()
        sut = ListViewRepositoryFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeRepository_shouldReturnCorrectType() {
        let repository = sut.makeListViewRepository()
        XCTAssertTrue(repository is ListViewRepository)
    }
}

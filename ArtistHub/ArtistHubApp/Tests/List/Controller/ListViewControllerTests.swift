import XCTest
@testable import ArtistHubApp

class ListViewControllerTests: XCTestCase {

    var sut: ListViewController!
    var view: ListView!

    override func setUp() {
        super.setUp()
        sut = ListViewController()
        view = sut.view as? ListView
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenViewIsLoaded_shouldSetProperTitle() {
        XCTAssertEqual(sut.title, "Artist Hub")
    }

    func test_whenViewIsLoaded_shouldRegisterCellForIndentifier() {
        let cell = view.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ListViewCell)
    }

    func test_whenViewIsLoaded_shouldPopulateSampleData() {
        XCTAssertEqual(view.collectionView.numberOfSections, 1)
        XCTAssertEqual(view.collectionView.numberOfItems(inSection: 0), 40)
    }
}

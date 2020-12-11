import XCTest
@testable import ArtistHubApp

class ListViewControllerTests: XCTestCase {

    var imageManagerSpy: ImageManagerSpy!
    var listViewRepositoryStub: ListViewRepositoryStub!
    var sut: ListViewController!
    var view: ListView!

    override func setUp() {
        super.setUp()
        imageManagerSpy = ImageManagerSpy()
        listViewRepositoryStub = ListViewRepositoryStub()
        sut = ListViewController(listViewRepository: listViewRepositoryStub, imageManager: imageManagerSpy)
        view = sut.view as? ListView
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        view = nil
    }

    func test_whenViewIsLoaded_shouldSetProperTitle() {
        XCTAssertEqual(sut.title, "Artist Hub")
    }

    func test_whenViewIsLoaded_shouldRegisterCellForIdentifier() {
        let cell = view.collectionView.dequeueReusableCell(withReuseIdentifier: "ListViewCell", for: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ListViewCell)
    }

    func test_whenViewIsLoaded_shouldPopulateSampleData() {
        XCTAssertEqual(view.collectionView.numberOfSections, 1)
        XCTAssertEqual(view.collectionView.numberOfItems(inSection: 0), 5)
    }
}

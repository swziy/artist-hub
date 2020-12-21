import XCTest
@testable import ArtistHubApp

class ListViewControllerTests: XCTestCase {

    var imageManagerSpy: ImageManagerSpy!
    var listViewRepositorySpy: ListViewRepositorySpy!
    var sut: ListViewController!

    override func setUp() {
        super.setUp()
        imageManagerSpy = ImageManagerSpy()
        listViewRepositorySpy = ListViewRepositorySpy()
        sut = ListViewController(listViewRepository: listViewRepositorySpy, imageManager: imageManagerSpy)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        imageManagerSpy = nil
        listViewRepositorySpy = nil
    }

    func test_whenViewIsLoaded_shouldSetProperTitle() {
        _ = sut.loadView(ListView.self)

        XCTAssertEqual(sut.title, "Artist Hub")
    }

    func test_whenViewIsLoaded_shouldRegisterCellForIdentifier() {
        let view = sut.loadView(ListView.self)
        let cell = view.collectionView.dequeueReusableCell(withReuseIdentifier: "ListViewCell", for: IndexPath(row: 0, section: 0))

        XCTAssertTrue(cell is ListViewCell)
    }

    func test_whenViewIsLoaded_shouldPopulateSampleData() {
        let view = sut.loadView(ListView.self)

        XCTAssertEqual(view.collectionView.numberOfSections, 1)
        XCTAssertEqual(view.collectionView.numberOfItems(inSection: 0), 5)
    }

    func test_whenViewIsLoadedAndApiErrorOccurs_shouldShowErrorView() {
        listViewRepositorySpy.stubbedLoadResult = .failure(.loadError)
        let view = sut.loadView(ListView.self)

        XCTAssertTrue(view.activityIndicator.isHidden)
        XCTAssertFalse(view.errorView.isHidden)
    }

    func test_whenViewIsLoadedAndApiErrorOccursThenRetryButtonIsTapped_shouldLoadData() {
        listViewRepositorySpy.stubbedLoadResult = .failure(.loadError)
        let view = sut.loadView(ListView.self)

        listViewRepositorySpy.stubbedLoadResult = .success(.testData)
        view.errorView.retryButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(listViewRepositorySpy.invokedLoadWith.count, 2)
        XCTAssertTrue(view.activityIndicator.isHidden)
        XCTAssertTrue(view.errorView.isHidden)
        XCTAssertEqual(view.collectionView.numberOfSections, 1)
        XCTAssertEqual(view.collectionView.numberOfItems(inSection: 0), 5)
    }
}

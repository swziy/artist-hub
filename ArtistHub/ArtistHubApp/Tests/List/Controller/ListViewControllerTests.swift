import ArtistHubCore
import UIKit
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

    func test_whenViewIsLoadedAndItemIsMarkedAsFavourite_shouldUpdateItemInRepository() {
        listViewRepositorySpy.stubbedLoadResult = .success(.testData)
        let view = delayedLoadView(ListView.self, for: sut)

        let cell = view.collectionView.visibleCells[1] as! ListViewCell
        cell.favouriteButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(listViewRepositorySpy.invokedUpdateWith.count, 1)
        XCTAssertEqual(listViewRepositorySpy.invokedUpdateWith[0].id, 2)
        XCTAssertTrue(listViewRepositorySpy.invokedUpdateWith[0].isFavorite)
    }

    func test_whenViewIsLoadedAndFavoritesAreChosen_shouldDisplayOnyFavoriteItems() {
        listViewRepositorySpy.stubbedLoadResult = .success([
            .testData(with: 1),
            .testData(with: 2, favorite: true)
        ])

        let view = delayedLoadView(ListView.self, for: sut)
        let sectionHeader = view.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as! ListViewHeader

        sectionHeader.segmentedControl.selectedSegmentIndex = 1
        sectionHeader.segmentedControl.sendActions(for: .valueChanged)

        let cell = view.collectionView.visibleCells[0] as! ListViewCell

        XCTAssertEqual(view.collectionView.visibleCells.count, 1)
        XCTAssertEqual(cell.favouriteButton.isSelected, true)
        XCTAssertEqual(cell.descriptionLabel.text, Artist.testData(with: 2, favorite: true).description)
    }

    func test_whenCellIsDisplayed_shouldStartImageDownload() {
        listViewRepositorySpy.stubbedLoadResult = .success(.testData)
        imageManagerSpy.stubbedResult = .success(UIImage.testData)
        _ = sut.loadView(ListView.self)

        XCTAssertEqual(imageManagerSpy.invokedGetImageWithUrl.count, 5)
    }

    func test_whenCellEndsDisplaying_shouldStartImageDownload() {
        listViewRepositorySpy.stubbedLoadResult = .success(.testData)
        imageManagerSpy.stubbedResult = .success(UIImage.testData)
        let view = delayedLoadView(ListView.self, for: sut)

        let cell = view.collectionView.visibleCells[0] as! ListViewCell
        view.collectionView.delegate?.collectionView?(view.collectionView, didEndDisplaying: cell, forItemAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(imageManagerSpy.invokedCancelImageWithUrl.count, 1)
    }
}

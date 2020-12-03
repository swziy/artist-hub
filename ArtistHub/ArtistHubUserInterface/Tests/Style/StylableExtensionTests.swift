import XCTest
@testable import ArtistHubUserInterface

class StylableExtensionTests: XCTestCase {

    func test_whenInitForView_shouldApplyStyle() {
        let sut = UIView(style: .init {
            $0.backgroundColor = UIColor.red
        })

        XCTAssertEqual(sut.backgroundColor, UIColor.red)
    }

    func test_whenInitForCollectionView_shouldApplyStyle() {
        let layout = UICollectionViewFlowLayout()
        let sut = UICollectionView(layout: layout, style: .init {
            $0.backgroundColor = UIColor.red
        })

        XCTAssertEqual(sut.backgroundColor, UIColor.red)
        XCTAssertEqual(sut.collectionViewLayout, layout)
    }
}

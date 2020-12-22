import ArtistHubCore
import XCTest
@testable import ArtistHubApp

class ListViewRepositoryTests: XCTestCase {

    var artistListServiceStub: ArtistListServiceStub!
    var persistenceClientStub: PersistenceClientStub<ArtistEntity>!
    var sut: ListViewRepository!

    override func setUp() {
        super.setUp()
        artistListServiceStub = ArtistListServiceStub()
        persistenceClientStub = PersistenceClientStub()
        sut = ListViewRepository(artistListService: artistListServiceStub, persistentClient: persistenceClientStub)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        artistListServiceStub = nil
        persistenceClientStub = nil
    }

    func test_whenLoadIsInvoked_shouldReturnProperData() {
        var capturedResult: Result<[Artist], ListViewError>!
        sut.load { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(.testData))
    }

    func test_whenLoadIsInvokedAndNetworkLoadFails_shouldReturnLoadError() {
        artistListServiceStub.stubbedResult = .failure(.invalidParams)

        var capturedResult: Result<[Artist], ListViewError>!
        sut.load { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.loadError))
    }

    func test_whenLoadNetworkSucceedAndPersistentStoreReadFails_shouldReturnDataFromNetwork() {
        persistenceClientStub.stubbedFetchResult = .failure(.operationError)

        var capturedResult: Result<[Artist], ListViewError>!
        sut.load { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(.testData))
    }

    func test_whenLoadNetworkLoadSucceedAndPersistentStoreReadFails_shouldReturnDataFromNetwork() {
        let fetched = Artist.testData(with: 10, favorite: false)
        artistListServiceStub.stubbedResult = .success([fetched])

        let stored = Artist.testData(with: 10, favorite: true)
        persistenceClientStub.stubbedFetchResult = .success([stored])

        var capturedResult: Result<[Artist], ListViewError>!
        sut.load { result in
            capturedResult = result
        }

        let result = Artist.testData(with: 10, favorite: true)

        XCTAssertEqual(capturedResult, .success([result]))
    }

    func test_whenUpdateReportError_shouldReturnProperResult() {
        persistenceClientStub.stubbedSaveOrUpdateResult = .failure(.operationError)
        let result = sut.update(.testData(with: 1))

        XCTAssertEqual(result, false)
    }

    func test_whenUpdateSucceed_shouldReturnProperResult() {
        persistenceClientStub.stubbedSaveOrUpdateResult = .success(())
        let result = sut.update(.testData(with: 1))

        XCTAssertEqual(result, true)
    }

    func test_whenDataLoadedWithoutFavoriteItems_shouldReturnProperIds() {
        artistListServiceStub.stubbedResult = .success(.testData)

        var capturedResult: Result<[Artist], ListViewError>!
        sut.load { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(.testData))
        XCTAssertEqual(sut.allIds(), [1, 2, 3, 4, 5])
        XCTAssertEqual(sut.favoriteIds(), [])
    }

    func test_whenDataLoadedWithFavoriteItems_shouldReturnProperIds() {
        let data1 = Artist.testData(with: 1, favorite: true)
        let data2 = Artist.testData(with: 2, favorite: false)
        let data3 = Artist.testData(with: 4, favorite: true)
        let data4 = Artist.testData(with: 8, favorite: false)
        let artists = [data1, data2, data3, data4]
        artistListServiceStub.stubbedResult = .success(artists)

        var capturedResult: Result<[Artist], ListViewError>!
        sut.load { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(artists))
        XCTAssertEqual(sut.allIds(), [1, 2, 4, 8])
        XCTAssertEqual(sut.favoriteIds(), [1, 4])
    }
}

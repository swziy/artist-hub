import XCTest
@testable import ArtistHubCore

class ArtistListServiceTests: XCTestCase {

    var dispatcherStub: DispatcherStub!
    var networkClientSpy: NetworkClientSpy<[Artist]>!
    var sut: ArtistListService!

    override func setUp() {
        super.setUp()
        dispatcherStub = DispatcherStub()
        networkClientSpy = NetworkClientSpy()
        sut = ArtistListService(networkClient: networkClientSpy, completionDispatcher: dispatcherStub)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        networkClientSpy = nil
        dispatcherStub = nil
    }

    func test_whenDataIsReceived_shouldReturnSuccess() {
        var capturedResult: Result<[Artist], ApiError>!
        sut.getArtistList { (result) in
            capturedResult = result
        }

        let items = try! capturedResult.get()
        XCTAssertEqual(items.count, 5)
        XCTAssertEqual(items, .testData)
    }

    func test_whenErrorOccurs_shouldPassError() {
        networkClientSpy.stubbedResult = .failure(.invalidParams)

        var capturedResult: Result<[Artist], ApiError>!
        sut.getArtistList { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.invalidParams))
    }

    func test_whenInvoked_shouldUseProperUrl() {
        sut.getArtistList { _ in }

        XCTAssertEqual(networkClientSpy.capturedUrl, ["https://gist.githubusercontent.com/swziy/fdb13610fc7bd5b33556c0996a20af1f/raw/e31f537dc4a57368b9433e4e8966b87117fc22c3/artist-hub-list.json"])
    }
}

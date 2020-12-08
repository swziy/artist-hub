import XCTest
@testable import ArtistHubCore

class NetworkSessionFactoryTests: XCTestCase {

    var sut: NetworkSessionFactory!

    override func setUp() {
        super.setUp()
        sut = NetworkSessionFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeSession_shouldHaveCorrectType() {
        XCTAssertTrue(sut.makeNetworkSession() is URLSession)
    }

    func test_whenMakeSessionMultipleTimes_shouldReturnSameObject() {
        let firstSession = sut.makeNetworkSession() as? URLSession
        let secondSession = sut.makeNetworkSession() as? URLSession

        XCTAssertTrue(firstSession === secondSession)
    }

    func test_whenMakeSession_shouldHaveCorrectTimeoutIntervalForRequest() {
        let session = sut.makeNetworkSession() as! URLSession

        XCTAssertEqual(session.configuration.timeoutIntervalForRequest, 10)
    }

    func test_whenMakeSession_shouldHaveCorrectTimeoutIntervalForResource() {
        let session = sut.makeNetworkSession() as! URLSession

        XCTAssertEqual(session.configuration.timeoutIntervalForResource, 20)
    }

    func test_whenMakeSession_shouldHaveCorrectMaximumConnectionsPerHost() {
        let session = sut.makeNetworkSession() as! URLSession

        XCTAssertEqual(session.configuration.httpMaximumConnectionsPerHost, 2)
    }
}

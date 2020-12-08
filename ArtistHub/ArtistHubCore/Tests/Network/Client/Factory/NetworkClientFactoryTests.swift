import XCTest
@testable import ArtistHubCore

class NetworkClientFactoryTests: XCTestCase {

    var sut: NetworkClientFactory!

    override func setUp() {
        super.setUp()
        sut = NetworkClientFactory()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeNetworkClient_shouldHaveCorrectType() {
        let networkClient = sut.makeNetworkClient()
        XCTAssertTrue(networkClient is NetworkClient)
    }
}

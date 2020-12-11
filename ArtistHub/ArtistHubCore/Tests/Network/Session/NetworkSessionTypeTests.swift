import ArtistHubCore
import Foundation
import XCTest

class NetworkSessionTypeTest: XCTestCase {

    var sut: NetworkSessionType!

    override func setUp() {
        super.setUp()
        sut = URLSession.shared
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeDataTask_shouldHaveCorrectType() {
        let url = URL(string: "https://example.com")!
        let result = sut.makeDataTask(with: URLRequest(url: url)) { (_, _, _) in }
        XCTAssertTrue(result is URLSessionDataTask)
    }

    func test_whenMakeDownloadTask_shouldHaveCorrectType() {
        let url = URL(string: "https://example.com")!
        let result = sut.makeDownloadTask(with: URLRequest(url: url)) { (_, _, _) in }
        XCTAssertTrue(result is URLSessionDownloadTask)
    }
}

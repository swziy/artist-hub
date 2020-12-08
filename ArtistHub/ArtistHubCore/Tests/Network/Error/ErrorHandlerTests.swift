import XCTest
@testable import ArtistHubCore

class ErrorHandlerTests: XCTestCase {

    var sut: ErrorHandler!

    override func setUp() {
        super.setUp()
        sut = ErrorHandler()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenAnyErrorIsPresent_shouldReturnGeneralError() {
        let result = sut.handle(error: NSError(domain: "test", code: -1), response: nil, data: nil)
        XCTAssertEqual(result, .generalError)
    }

    func test_whenErrorIsWithCancelledCode_shouldReturnCancelledError() {
        let result = sut.handle(error: URLError(.cancelled), response: nil, data: nil)
        XCTAssertEqual(result, .cancelled)
    }

    func test_whenResponseIsMissing_shouldReturnGeneralError() {
        let result = sut.handle(error: nil, response: nil, data: nil)
        XCTAssertEqual(result, .generalError)
    }

    func test_whenResponseHasStatusCodeLowerThan200_shouldReturnGeneralError() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 100,
            httpVersion: nil,
            headerFields: nil
        )

        let result = sut.handle(error: nil, response: response, data: nil)
        XCTAssertEqual(result, .generalError)
    }

    func test_whenResponseHasStatusCodeHigherThan299_shouldReturnGeneralError() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 300,
            httpVersion: nil,
            headerFields: nil
        )

        let result = sut.handle(error: nil, response: response, data: nil)
        XCTAssertEqual(result, .generalError)
    }

    func test_whenDataIsEmpty_shouldReturnGeneralError() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let result = sut.handle(error: nil, response: response, data: nil)
        XCTAssertEqual(result, .generalError)
    }

    func test_whenSessionReturnsCompleteData_shouldReturnNoError() {
        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """

        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let data = json.data(using: .utf8)

        let result = sut.handle(error: nil, response: response, data: data)
        XCTAssertEqual(result, nil)
    }
}

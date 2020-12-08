import XCTest
@testable import ArtistHubCore

class NetworkClientTests: XCTestCase {

    var networkSessionStub: NetworkSessionStub!
    var sut: NetworkClient!

    override func setUp() {
        super.setUp()
        networkSessionStub = NetworkSessionStub()
        sut = NetworkClient(networkSession: networkSessionStub)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        networkSessionStub = nil
    }

    func test_whenUrlIsMalformed_shouldReturnInvalidParams() {
        let malformedUrl = "<not_an_url>"
        var capturedResult: Result<TestModel, ApiError>!
        sut.request(url: malformedUrl) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.invalidParams))
    }

    func test_whenSessionReturnsError_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = NSError(domain: "test", code: -1)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
    }

    func test_whenSessionReturnsErrorWithCancelledCode_shouldReturnCancelledError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = URLError(.cancelled)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.cancelled))
    }

    func test_whenSessionReturnsEmptyResponse_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedResponse = nil

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
    }

    func test_whenSessionReturnsStatusCodeLowerThan200_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 100,
            httpVersion: nil,
            headerFields: nil
        )

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
    }

    func test_whenSessionReturnsStatusCodeHigherThan299_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 300,
            httpVersion: nil,
            headerFields: nil
        )

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
    }

    func test_whenSessionReturnsEmptyData_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        networkSessionStub.stubbedData = nil

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
    }

    func test_whenSessionReturnsCompleteData_shouldReturnSuccess() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!
        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(TestModel(id: "<id>", name: "<name>")))
    }

    func test_whenSessionReturnsMalformedData_shouldReturnParseError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!
        let json = """
        {
            "malformed...
            "id": "<id>",
            "name": "<name>"
        }
        """

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.parseError))
    }

    func test_whenSessionReturnsCompleteDataAndTryToParseToIncompleteModel_shouldReturnSuccess() {
        let url = "https://example.com"
        var capturedResult: Result<TestIncompleteModel, ApiError>!
        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(TestIncompleteModel(id: "<id>")))
    }

    func test_whenSessionReturnsCompleteDataAndTryToParseToWrongModel_shouldReturnSuccess() {
        let url = "https://example.com"
        var capturedResult: Result<TestWrongModel, ApiError>!
        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.parseError))
    }
}

private struct TestModel: Equatable, Decodable {
    let id: String
    let name: String
}

private struct TestIncompleteModel: Equatable, Decodable {
    let id: String
}

private struct TestWrongModel: Equatable, Decodable {
    let ids: String
    let name: String
}

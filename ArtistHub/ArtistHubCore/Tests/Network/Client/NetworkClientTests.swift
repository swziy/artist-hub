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

    func test_dataTask_whenUrlIsMalformed_shouldReturnInvalidParams() {
        let malformedUrl = "<not_an_url>"
        var capturedResult: Result<TestModel, ApiError>!
        sut.request(url: malformedUrl) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.invalidParams))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 0)
    }

    func test_dataTask_whenSessionReturnsError_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = NSError(domain: "test", code: -1)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsErrorWithCancelledCode_shouldReturnCancelledError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = URLError(.cancelled)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.cancelled))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsEmptyResponse_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedResponse = nil

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsStatusCodeLowerThan200_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.info

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsStatusCodeHigherThan299_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.redirect

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsEmptyData_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok
        networkSessionStub.stubbedData = nil

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsCompleteData_shouldReturnSuccess() {
        let url = "https://example.com"
        var capturedResult: Result<TestModel, ApiError>!
        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(TestModel(id: "<id>", name: "<name>")))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsMalformedData_shouldReturnParseError() {
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
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.parseError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsCompleteDataAndTryToParseToIncompleteModel_shouldReturnSuccess() {
        let url = "https://example.com"
        var capturedResult: Result<TestIncompleteModel, ApiError>!
        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .success(TestIncompleteModel(id: "<id>")))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_dataTask_whenSessionReturnsCompleteDataAndTryToParseToWrongModel_shouldReturnSuccess() {
        let url = "https://example.com"
        var capturedResult: Result<TestWrongModel, ApiError>!
        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok
        networkSessionStub.stubbedData = json.data(using: .utf8)

        sut.request(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.parseError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenUrlIsMalformed_shouldReturnInvalidParams() {
        let malformedUrl = "<not_an_url>"
        var capturedResult: Result<Data, ApiError>!
        sut.download(url: malformedUrl) { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.invalidParams))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 0)
    }

    func test_downloadTask_whenSessionReturnsCompleteData_shouldReturnProperData() {
        let malformedUrl = "https://example.com"

        let resourceUrl = Bundle.test.url(forResource: "vincent", withExtension: "png")!
        networkSessionStub.stubbedLocationUrl = resourceUrl
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok

        var capturedResult: Result<Data, ApiError>!
        sut.download(url: malformedUrl) { result in
            capturedResult = result
        }

        let data = try! Data(contentsOf: resourceUrl)

        XCTAssertEqual(capturedResult, .success(data))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenSessionReturnsError_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<Data, ApiError>!

        networkSessionStub.stubbedError = NSError(domain: "test", code: -1)

        sut.download(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenSessionReturnsErrorWithCancelledCode_shouldReturnCancelledError() {
        let url = "https://example.com"
        let resourceUrl = Bundle.test.url(forResource: "vincent", withExtension: "png")!
        var capturedResult: Result<Data, ApiError>!

        networkSessionStub.stubbedError = URLError(.cancelled)
        networkSessionStub.stubbedLocationUrl = resourceUrl
        networkSessionStub.stubbedData = Data()

        sut.download(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.cancelled))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenSessionReturnsEmptyResponse_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<Data, ApiError>!

        networkSessionStub.stubbedResponse = nil

        sut.download(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenSessionReturnsStatusCodeLowerThan200_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<Data, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.info

        sut.download(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenSessionReturnsStatusCodeHigherThan299_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<Data, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.redirect

        sut.download(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenSessionReturnsEmptyData_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<Data, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok
        networkSessionStub.stubbedData = nil

        sut.download(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
    }

    func test_downloadTask_whenCantDecodeDataFromLocation_shouldReturnGeneralError() {
        let url = "https://example.com"
        var capturedResult: Result<Data, ApiError>!

        networkSessionStub.stubbedError = nil
        networkSessionStub.stubbedResponse = HTTPURLResponse.ok
        networkSessionStub.stubbedLocationUrl = URL(string: "file://not/a/resource")

        sut.download(url: url) { (result) in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.generalError))
        XCTAssertEqual(networkSessionStub.stubbedTask.invokedResume, 1)
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

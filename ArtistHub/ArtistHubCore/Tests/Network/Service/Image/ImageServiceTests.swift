import XCTest
@testable import ArtistHubCore

class ImageServiceTests: XCTestCase {

    var dispatcherStub: DispatcherStub!
    var networkClientSpy: NetworkClientSpy<Never>!
    var sut: ImageService!

    override func setUp() {
        super.setUp()
        dispatcherStub = DispatcherStub()
        networkClientSpy = NetworkClientSpy()
        sut = ImageService(networkClient: networkClientSpy, completionDispatcher: dispatcherStub)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        networkClientSpy = nil
        dispatcherStub = nil
    }

    func test_whenDataIsReceived_shouldReturnSuccess() {
        let image = UIImage(named: "vincent", in: .test, compatibleWith: nil)!

        let imageData = image.pngData()!
        networkClientSpy.stubbedDownloadTaskResult = .success(imageData)

        var capturedResult: Result<UIImage, ImageError>!
        let _ = sut.getImage(url: "<test_url>") { result in
            capturedResult = result
        }
        let resultImage = try! capturedResult.get()
        let imageFromData = UIImage(data: imageData)!

        XCTAssertEqual(resultImage.size, imageFromData.size)
        XCTAssertEqual(capturedResult, .success(resultImage))
    }

    func test_whenDataIsMalformed_shouldReturnDecodingError() {
        let bytes: [Int8] = [1, 2, 3]
        networkClientSpy.stubbedDownloadTaskResult = .success(Data(bytes: bytes, count: 3))

        var capturedResult: Result<UIImage, ImageError>!
        let _ = sut.getImage(url: "<test_url>") { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.decodingError))
    }

    func test_whenDataErrorOccurs_shouldReturnDownloadError() {
        networkClientSpy.stubbedDownloadTaskResult = .failure(.generalError)

        var capturedResult: Result<UIImage, ImageError>!
        let _ = sut.getImage(url: "<test_url>") { result in
            capturedResult = result
        }

        XCTAssertEqual(capturedResult, .failure(.downloadError))
    }

    func test_whenInvoked_shouldPassProperUrl() {
        let _ = sut.getImage(url: "<test_url>") { result in }

        XCTAssertEqual(networkClientSpy.capturedUrl, ["<test_url>"])
    }
}

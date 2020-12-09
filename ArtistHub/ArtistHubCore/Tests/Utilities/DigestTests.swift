import XCTest
@testable import ArtistHubCore

class DigestTest: XCTestCase {

    var sut: Digest.Type!

    override func setUp() {
        super.setUp()
        sut = Digest.self
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenSHA256Calculated_shouldReturnProperData() {
        let data = "<input_test_data>"
        let result = sut.sha256(from: data)

        XCTAssertEqual(result, "e99277a3c1c0031401afef9b4fc7ec9be277d64e3b04095c1d4963c5aab568eb")
    }

    func test_whenSHA256CalculatedForSameInput_shouldReturnProperData() {
        let firstData = "<input_test_data>"
        let firstResult = sut.sha256(from: firstData)
        let secondData = "<input_test_data>"
        let secondResult = sut.sha256(from: secondData)

        XCTAssertEqual(firstResult, "e99277a3c1c0031401afef9b4fc7ec9be277d64e3b04095c1d4963c5aab568eb")
        XCTAssertEqual(firstResult, secondResult)
    }
}

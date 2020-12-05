import XCTest
@testable import ArtistHubCore

class AsyncDispatcherTests: XCTestCase {

    var sut: AsyncDispatcher!

    override func setUp() {
        super.setUp()
        sut = AsyncDispatcher(dispatchQueue: DispatchQueue.main)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenWorkIsDispatched_shouldBeExecuted() {
        let executionExpectation = expectation(description: "work done")
        sut.dispatch {
            executionExpectation.fulfill()
        }

        wait(for: [executionExpectation], timeout: 1)
    }
}

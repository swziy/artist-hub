import XCTest
@testable import ArtistHubCore

class SyncDispatcherTests: XCTestCase {

    var sut: SyncDispatcher!

    override func setUp() {
        super.setUp()
        sut = SyncDispatcher(dispatchQueue: DispatchQueue(label: "serial.queue"))
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenWorkIsDispatched_shouldBeExecuted() {
        var done = false
        sut.dispatch {
            done = true
        }

        XCTAssertTrue(done)
    }
}

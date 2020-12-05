import XCTest
@testable import ArtistHubCore

class TaskTests: XCTestCase {

    var order: [String] = []
    var sut: Task!

    func test_whenExecuted_shouldInvokeInOrder() {
        sut = Task(execution: {
            self.order.append("1")
        }, completion: {
            self.order.append("2")
        })

        sut.execute()

        XCTAssertEqual(order, ["1", "2"])
    }
}

import XCTest
@testable import ArtistHubCore

class TaskTests: XCTestCase {

    var order: [String] = []
    var sut: Task<Int>!

    func test_whenExecuted_shouldInvokeInOrder() {
        sut = Task(execution: {
            self.order.append("1")
            return 3
        }, completion: {
            self.order.append("2")
            self.order.append("\($0)")
        })

        sut.execute()

        XCTAssertEqual(order, ["1", "2", "3"])
    }
}

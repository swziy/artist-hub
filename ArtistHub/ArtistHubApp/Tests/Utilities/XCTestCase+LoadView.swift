import XCTest

extension XCTestCase {

    func delayedLoadView<T: UIView>(_ viewType: T.Type, for controller: UIViewController) -> T {
        let typedView = controller.loadView(viewType)
        wait(timeout: 0.05)

        return typedView
    }

    func wait(timeout: TimeInterval) {
        let expectation = XCTestExpectation(description: "Waiting for \(timeout) seconds")
        XCTWaiter().wait(for: [expectation], timeout: timeout)
    }
}

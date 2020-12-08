import Foundation

class URLSessionDataTaskSpy: URLSessionDataTask {

    private(set) var invokedResume = 0
    let completion: (() -> Void)?

    // MARK: - Initialization

    init(completion: (() -> Void)? = nil) {
        self.completion = completion
    }

    // MARK: - URLSessionDataTask

    override func resume() {
        invokedResume += 1
        completion?()
    }
}

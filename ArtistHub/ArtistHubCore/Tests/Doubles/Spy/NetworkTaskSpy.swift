import Foundation
@testable import ArtistHubCore

class NetworkTaskSpy: NetworkTaskType {

    private(set) var invokedResume = 0
    private(set) var invokedCancel = 0

    // MARK: - NetworkTaskType

    func cancel() {
        invokedCancel += 1
    }

    func resume() {
        invokedResume += 1
    }
}

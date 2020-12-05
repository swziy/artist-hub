public final class SyncDispatcher: DispatcherType {

    private let dispatchQueue: DispatchQueue

    public init(dispatchQueue: DispatchQueue) {
        self.dispatchQueue = dispatchQueue
    }

    // MARK: - DispatcherType

    public func dispatch(_ work: @escaping () -> Void) {
        dispatchQueue.sync(execute: work)
    }
}

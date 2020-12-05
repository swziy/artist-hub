import ArtistHubCore

class DispatcherStub: DispatcherType {

    // MARK: - DispatcherType

    func dispatch(_ work: @escaping () -> Void) {
        work()
    }
}

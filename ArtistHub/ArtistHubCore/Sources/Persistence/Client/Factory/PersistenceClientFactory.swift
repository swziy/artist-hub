public struct PersistenceClientFactory {

    // MARK: - Initialization

    public init() {}

    public func makePersistenceClient() -> PersistenceClientType {
        let containerFactory = PersistentContainerFactory()

        return PersistenceClient(containerFactory: containerFactory)
    }
}

public struct ArtistListServiceFactory {

    // MARK: - Initialization

    public init() {}

    // MARK: - Public

    public func makeArtistListService() -> ArtistListServiceType {
        let networkClient = NetworkClientFactory().makeNetworkClient()
        let completionDispatcher = AsyncDispatcher(dispatchQueue: DispatchQueue.main)

        return ArtistListService(networkClient: networkClient, completionDispatcher: completionDispatcher)
    }
}

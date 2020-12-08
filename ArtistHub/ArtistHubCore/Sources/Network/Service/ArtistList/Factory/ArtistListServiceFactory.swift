public struct ArtistListServiceFactory: ArtistListServiceFactoryType {

    // MARK: - Initialization

    public init() {}

    // MARK: - ArtistListServiceFactoryType

    public func makeArtistListService() -> ArtistListServiceType {
        let networkClient = NetworkClientFactory().makeNetworkClient()
        let completionDispatcher = AsyncDispatcher(dispatchQueue: DispatchQueue.main)

        return ArtistListService(networkClient: networkClient, completionDispatcher: completionDispatcher)
    }
}

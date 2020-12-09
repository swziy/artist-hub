public struct ImageServiceFactory {

    // MARK: - Initialization

    public init() {}

    // MARK: - Public

    public func makeImageService() -> ImageServiceType {
        let networkClient = NetworkClientFactory().makeNetworkClient()
        let completionDispatcher = AsyncDispatcher(dispatchQueue: DispatchQueue.main)

        return ImageService(networkClient: networkClient, completionDispatcher: completionDispatcher)
    }
}

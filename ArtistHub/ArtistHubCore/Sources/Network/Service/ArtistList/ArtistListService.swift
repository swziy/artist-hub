final class ArtistListService: ArtistListServiceType {

    private let url: String = {
        "https://gist.githubusercontent.com/swziy/fdb13610fc7bd5b33556c0996a20af1f/raw/c9a537f8ec230bb9959143b59330fc369a9fcd56/artist-hub-list.json"
    }()

    private let networkClient: NetworkClientType
    private let completionDispatcher: DispatcherType

    // MARK: - Initialization

    init(networkClient: NetworkClientType, completionDispatcher: DispatcherType) {
        self.networkClient = networkClient
        self.completionDispatcher = completionDispatcher
    }

    // MARK: - ArtistListServiceType

    func getArtistList(with completion: @escaping (Result<[Artist], ApiError>) -> Void) {
        networkClient.request(url: url, completion: { [completionDispatcher] (result: Result<[Artist], ApiError>) in
            completionDispatcher.dispatch {
                completion(result)
            }
        })
    }
}

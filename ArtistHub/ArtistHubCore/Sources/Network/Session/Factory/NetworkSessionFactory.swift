struct NetworkSessionFactory: NetworkSessionFactoryType {

    private static let sharedSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 20
        configuration.httpMaximumConnectionsPerHost = 2

        return URLSession(configuration: configuration)
    }()

    // MARK: - NetworkSessionFactoryType

    func makeNetworkSession() -> NetworkSessionType {
        NetworkSessionFactory.sharedSession
    }
}

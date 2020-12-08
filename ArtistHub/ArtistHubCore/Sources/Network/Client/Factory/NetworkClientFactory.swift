struct NetworkClientFactory: NetworkClientFactoryType {

    // MARK: - NetworkClientFactoryType

    func makeNetworkClient() -> NetworkClientType {
        let networkSession = NetworkSessionFactory().makeNetworkSession()
        return NetworkClient(networkSession: networkSession)
    }
}

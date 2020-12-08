public protocol NetworkClientType {
    @discardableResult
    func request<R: Decodable>(
        url: String,
        completion: @escaping (Result<R, ApiError>) -> Void
    ) -> NetworkTaskType?

    @discardableResult
    func download(
        url: String,
        completion: @escaping (Result<Data, ApiError>) -> Void
    ) -> NetworkTaskType?
}

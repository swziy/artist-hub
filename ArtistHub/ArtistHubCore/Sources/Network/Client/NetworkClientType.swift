public protocol NetworkClientType {
    @discardableResult
    func request<R: Decodable>(
        url: String,
        completion: @escaping (Result<R, ApiError>) -> Void
    ) -> URLSessionDataTask?
}

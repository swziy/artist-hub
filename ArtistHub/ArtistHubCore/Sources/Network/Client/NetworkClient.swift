final class NetworkClient: NetworkClientType {

    private let errorHandler = ErrorHandler()
    private let networkSession: NetworkSessionType

    // MARK: - Initialization

    init(networkSession: NetworkSessionType) {
        self.networkSession = networkSession
    }

    // MARK: - NetworkClientType

    @discardableResult
    func request<R: Decodable>(
        url: String,
        completion: @escaping (Result<R, ApiError>) -> Void
    ) -> URLSessionDataTask? {
        let task = try? dataTask(url: url, completion: completion)
        task?.resume()
        return task
    }

    // MARK: - Private

    private func dataTask<R: Decodable>(
        url: String,
        completion: @escaping (Result<R, ApiError>) -> Void
    ) throws -> URLSessionDataTask {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidParams))
            throw ApiError.invalidParams
        }

        let request = URLRequest(url: url)
        let dataTask = networkSession.dataTask(with: request) { [errorHandler] (data, response, error) in
            if let error = errorHandler.handle(error: error, response: response, data: data) {
                completion(.failure(error))
                return
            }

            do {
                let model = try JSONDecoder().decode(R.self, from: data!)
                completion(.success(model))
            } catch {
                completion(.failure(.parseError))
            }
        }

        return dataTask
    }
}

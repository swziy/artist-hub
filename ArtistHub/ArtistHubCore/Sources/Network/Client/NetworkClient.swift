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
    ) -> NetworkTaskType? {
        let task = try? dataTask(url: url, completion: completion)
        task?.resume()
        return task
    }

    @discardableResult
    func download(
        url: String,
        completion: @escaping (Result<Data, ApiError>) -> Void
    ) -> NetworkTaskType? {
        let task = try? downloadTask(url: url, completion: completion)
        task?.resume()
        return task
    }

    // MARK: - Private

    private func dataTask<R: Decodable>(
        url: String,
        completion: @escaping (Result<R, ApiError>) -> Void
    ) throws -> NetworkTaskType {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidParams))
            throw ApiError.invalidParams
        }

        let dataTask = networkSession.makeDataTask(with: URLRequest(url: url)) { [errorHandler] (data, response, error) in
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

    private func downloadTask(
        url: String,
        completion: @escaping (Result<Data, ApiError>) -> Void
    ) throws -> NetworkTaskType? {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidParams))
            throw ApiError.invalidParams
        }

        let downloadTask = networkSession.makeDownloadTask(with: URLRequest(url: url)) { [errorHandler] location, response, error in
            guard let location = location else {
                completion(.failure(.generalError))
                return
            }

            guard let data = try? Data(contentsOf: location) else {
                completion(.failure(.generalError))
                return
            }

            if let error = errorHandler.handle(error: error, response: response, data: data) {
                completion(.failure(error))
                return
            }

            completion(.success(data))
        }

        return downloadTask
    }
}

import ArtistHubCore

class NetworkClientSpy<T: TestDataAccessible>: NetworkClientType {

    var stubbedResult: Result<T.TestDataType, ApiError> = .success(T.testData)

    private(set) var capturedUrl: [String] = []

    // MARK: - NetworkClientType

    func request<R: Decodable>(
        url: String,
        completion: @escaping (Result<R, ApiError>) -> Void
    ) -> URLSessionDataTask? {
        capturedUrl.append(url)

        let result = stubbedResult as! Result<R, ApiError>
        completion(result)
        
        return nil
    }
}

import ArtistHubCore

class NetworkClientSpy<T: TestDataAccessible>: NetworkClientType {

    var stubbedDataTaskResult: Result<T.TestDataType, ApiError> = .success(T.testData)
    var stubbedDownloadTaskResult: Result<Data, ApiError> = .success(Data())
    var stubbedTask: NetworkTaskSpy! = NetworkTaskSpy()

    private(set) var capturedUrl: [String] = []

    // MARK: - NetworkClientType

    func request<R: Decodable>(url: String, completion: @escaping (Result<R, ApiError>) -> Void) -> NetworkTaskType? {
        capturedUrl.append(url)

        let result = stubbedDataTaskResult as! Result<R, ApiError>
        completion(result)

        return stubbedTask
    }

    func download(url: String, completion: @escaping (Result<Data, ApiError>) -> Void) -> NetworkTaskType? {
        capturedUrl.append(url)

        let result = stubbedDownloadTaskResult
        completion(result)

        return stubbedTask
    }
}

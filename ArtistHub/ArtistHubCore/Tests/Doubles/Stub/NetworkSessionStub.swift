import ArtistHubCore

class NetworkSessionStub: NetworkSessionType {

    var stubbedData: Data?
    var stubbedResponse: URLResponse?
    var stubbedError: Error?
    var stubbedDataTask: URLSessionDataTaskSpy = URLSessionDataTaskSpy()

    // MARK: - NetworkSessionType

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(stubbedData, stubbedResponse, stubbedError)
        return stubbedDataTask
    }
}

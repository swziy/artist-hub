import ArtistHubCore

class NetworkSessionStub: NetworkSessionType {

    var stubbedData: Data?
    var stubbedResponse: URLResponse?
    var stubbedError: Error?
    var stubbedLocationUrl: URL?
    var stubbedTask: NetworkTaskSpy = NetworkTaskSpy()

    // MARK: - NetworkSessionType

    func makeDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkTaskType {
        completionHandler(stubbedData, stubbedResponse, stubbedError)
        return stubbedTask
    }

    func makeDownloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> NetworkTaskType {
        completionHandler(stubbedLocationUrl, stubbedResponse, stubbedError)
        return stubbedTask
    }
}

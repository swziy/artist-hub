public protocol NetworkSessionType {
    func makeDataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> NetworkTaskType

    func makeDownloadTask(
        with request: URLRequest,
        completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void
    ) -> NetworkTaskType
}

extension URLSession: NetworkSessionType {

    public func makeDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkTaskType {
        dataTask(with: request, completionHandler: completionHandler)
    }

    public func makeDownloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> NetworkTaskType {
        downloadTask(with: request, completionHandler: completionHandler)
    }
}

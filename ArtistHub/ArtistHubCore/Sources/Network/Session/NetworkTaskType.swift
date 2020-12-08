import Foundation

public protocol NetworkTaskType {
    func resume()
    func cancel()
}

extension URLSessionDataTask: NetworkTaskType {}
extension URLSessionDownloadTask: NetworkTaskType {}

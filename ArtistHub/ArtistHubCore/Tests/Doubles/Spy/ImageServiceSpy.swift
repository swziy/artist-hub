import ArtistHubCore
import UIKit

class ImageServiceSpy: ImageServiceType {

    var stubbedResult: Result<UIImage, ImageError> = .success(.testData)
    var stubbedTask: NetworkTaskSpy = .init()
    var shouldInvokeCompletion: Bool = true

    private(set) var invokedWithUrl: [String] = []

    // MARK: - ImageServiceType

    func getImage(url: String, with completion: @escaping (Result<UIImage, ImageError>) -> Void) -> NetworkTaskType? {
        invokedWithUrl.append(url)

        if shouldInvokeCompletion {
            completion(stubbedResult)
        }

        return stubbedTask
    }
}

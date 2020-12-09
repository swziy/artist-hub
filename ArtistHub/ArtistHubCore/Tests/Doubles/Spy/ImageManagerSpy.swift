import ArtistHubCore
import UIKit

class ImageManagerSpy: ImageManagerType {

    var stubbedResult: Result<UIImage, ImageError> = .failure(.downloadError)
    private(set) var invokedGetImageWithUrl: [String] = []
    private(set) var invokedCancelImageWithUrl: [String] = []

    // MARK: - ImageManagerType

    func getImage(for url: String, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
        invokedGetImageWithUrl.append(url)
        completion(stubbedResult)
    }

    func cancelImage(for url: String) {
        invokedCancelImageWithUrl.append(url)
    }
}

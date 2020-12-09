import UIKit

class ImageService: ImageServiceType {

    private let networkClient: NetworkClientType
    private let completionDispatcher: DispatcherType

    // MARK: - Initialization

    init(networkClient: NetworkClientType, completionDispatcher: DispatcherType) {
        self.networkClient = networkClient
        self.completionDispatcher = completionDispatcher
    }

    // MARK: - ImageServiceType

    func getImage(url: String, with completion: @escaping (Result<UIImage, ImageError>) -> Void) -> NetworkTaskType? {
        networkClient.download(url: url) { [completionDispatcher] result in
            let mappedResult = result
                .mapError { _ in ImageError.downloadError }
                .flatMap { data -> Result<UIImage, ImageError> in
                    guard let image = UIImage(data: data) else {
                        return .failure(.decodingError)
                    }

                    return .success(image)
                }

            completionDispatcher.dispatch {
                completion(mappedResult)
            }
        }
    }
}

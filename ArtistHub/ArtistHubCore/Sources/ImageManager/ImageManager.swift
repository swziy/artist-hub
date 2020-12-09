import UIKit

final class ImageManager: ImageManagerType {

    private var activeTasks: [String: NetworkTaskType] = [:]
    private let imageCache: ImageCacheType
    private let imageService: ImageServiceType

    // MARK: - Initialization

    init(imageService: ImageServiceType, imageCache: ImageCacheType) {
        self.imageCache = imageCache
        self.imageService = imageService
    }

    // MARK: - ImageManagerType

    func getImage(for url: String, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
        let cacheKey = Digest.sha256(from: url)
        if let image = imageCache.image(for: cacheKey) {
            completion(.success(image))
            return
        }

        guard activeTasks[url] == nil else {
            return
        }

        let task = imageService.getImage(url: url) { [weak self] (result) in
            self?.activeTasks[url] = nil
            if let image = try? result.get() {
                self?.imageCache.set(image: image, for: cacheKey)
            }
            completion(result)
        }

        activeTasks[url] = task
    }

    func cancelImage(for url: String) {
        activeTasks[url]?.cancel()
        activeTasks[url] = nil
    }
}

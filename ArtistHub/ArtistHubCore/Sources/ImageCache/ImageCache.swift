import UIKit

final class ImageCache: ImageCacheType {

    static let shared: ImageCache = .init()

    private var cache: [String: UIImage] = [:]

    // MARK: - Initialization

    private init() {}

    // MARK: - ImageCacheType

    func image(for key: String) -> UIImage? {
        cache[key]
    }

    func set(image: UIImage, for key: String) {
        cache[key] = image
    }
}

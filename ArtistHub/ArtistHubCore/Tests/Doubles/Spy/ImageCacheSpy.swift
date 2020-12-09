import UIKit
@testable import ArtistHubCore

class ImageCacheSpy: ImageCacheType {

    var cache: [String: UIImage] = [:]
    private(set) var invokedGetWithKey: [String] = []
    private(set) var invokedSetWithKey: [String] = []

    // MARK: - ImageCacheType

    func image(for key: String) -> UIImage? {
        invokedGetWithKey.append(key)
        return cache[key]
    }

    func set(image: UIImage, for key: String) {
        invokedSetWithKey.append(key)
        cache[key] = image
    }
}

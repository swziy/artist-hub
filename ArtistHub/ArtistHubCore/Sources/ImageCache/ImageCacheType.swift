import UIKit

protocol ImageCacheType {
    func image(for key: String) -> UIImage?
    func set(image: UIImage, for key: String)
}

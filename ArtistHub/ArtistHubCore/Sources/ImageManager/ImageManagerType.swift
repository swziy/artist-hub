import UIKit

public protocol ImageManagerType {
    func getImage(for url: String, completion: @escaping (Result<UIImage, ImageError>) -> Void)
    func cancelImage(for url: String)
}

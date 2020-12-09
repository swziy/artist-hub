import UIKit

public enum ImageError: Error {
    case decodingError
    case downloadError
}

public protocol ImageServiceType {
    func getImage(url: String, with completion: @escaping (Result<UIImage, ImageError>) -> Void) -> NetworkTaskType?
}

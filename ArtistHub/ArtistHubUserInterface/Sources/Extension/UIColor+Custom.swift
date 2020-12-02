import UIKit

public extension UIColor {

    enum Fill {

        public static let accent: UIColor = .init(assetName: "AccentColor")
        public static let gray: UIColor = .init(assetName: "gray")
        public static let lightGray: UIColor = .init(assetName: "lightGray")
    }

    // MARK: - Private

    private convenience init(assetName: String) {
        self.init(named: assetName, in: Bundle.main, compatibleWith: nil)!
    }
}

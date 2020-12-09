import UIKit

extension UIImage: TestDataAccessible {

    static var testData: UIImage {
        UIImage(named: "vincent", in: .test, with: nil)!
    }
}

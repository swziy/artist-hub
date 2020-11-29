import UIKit

final class DetailsControllerFactory: DetailsControllerFactoryType {

    // MARK: - DetailsControllerFactoryType

    func makeDetailsController() -> DetailsViewController {
        DetailsViewController()
    }
}

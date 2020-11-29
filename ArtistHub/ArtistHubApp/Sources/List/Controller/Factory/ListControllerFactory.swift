import UIKit

class ListControllerFactory: ListControllerFactoryType {

    // MARK: - ListControllerFactoryType

    func makeListController() -> ListViewController {
        ListViewController()
    }
}

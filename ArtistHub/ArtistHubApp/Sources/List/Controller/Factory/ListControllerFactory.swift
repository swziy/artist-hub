import UIKit

class ListControllerFactory: ListControllerFactoryType {

    // MARK: - ListControllerFactoryType

    func makeListController() -> ListViewControllerType {
        ListViewController()
    }
}

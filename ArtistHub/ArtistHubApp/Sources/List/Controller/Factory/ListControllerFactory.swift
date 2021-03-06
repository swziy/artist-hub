import ArtistHubCore
import UIKit

final class ListControllerFactory: ListControllerFactoryType {

    // MARK: - ListControllerFactoryType

    func makeListController() -> ListViewControllerType {
        let listViewRepository = ListViewRepositoryFactory().makeListViewRepository()
        let imageManager = ImageManagerFactory().makeImageManager()

        return ListViewController(listViewRepository: listViewRepository, imageManager: imageManager)
    }
}

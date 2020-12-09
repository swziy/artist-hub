import UIKit
import ArtistHubCore

class ListControllerFactory: ListControllerFactoryType {

    // MARK: - ListControllerFactoryType

    func makeListController() -> ListViewControllerType {
        let artistListService = ArtistListServiceFactory().makeArtistListService()
        let imageManager = ImageManagerFactory().makeImageManager()

        return ListViewController(artistListService: artistListService, imageManager: imageManager)
    }
}

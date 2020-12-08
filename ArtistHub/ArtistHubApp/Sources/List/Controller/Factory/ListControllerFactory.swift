import UIKit
import ArtistHubCore

class ListControllerFactory: ListControllerFactoryType {

    // MARK: - ListControllerFactoryType

    func makeListController() -> ListViewControllerType {
        let artistListService = ArtistListServiceFactory().makeArtistListService()

        return ListViewController(artistListService: artistListService)
    }
}

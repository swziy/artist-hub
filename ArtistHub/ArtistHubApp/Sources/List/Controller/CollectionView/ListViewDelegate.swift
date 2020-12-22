import ArtistHubCore
import UIKit

final class ListViewDelegate: NSObject, UICollectionViewDelegate {

    weak var collectionView: UICollectionView?
    weak var listViewDataSource: ListViewDataSource?

    private let listViewRepository: ListViewRepositoryType
    private let imageManager: ImageManagerType

    // MARK: - Initialization

    init(listViewRepository: ListViewRepositoryType, imageManager: ImageManagerType) {
        self.listViewRepository = listViewRepository
        self.imageManager = imageManager
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let identifier = listViewDataSource?.dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        guard let item = listViewRepository.data[identifier] else {
            return
        }

        imageManager.getImage(for: item.avatar) { (result) in
            guard let cell = cell as? ListViewCell else {
                return
            }

            guard let image = try? result.get() else {
                return
            }

            UIView.transition(with: cell.avatarImageView, duration: 0.2, options: .transitionCrossDissolve) {
                cell.avatarImageView.image = image
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let identifier = listViewDataSource?.dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        guard let item = listViewRepository.data[identifier] else {
            return
        }

        imageManager.cancelImage(for: item.avatar)
    }
}

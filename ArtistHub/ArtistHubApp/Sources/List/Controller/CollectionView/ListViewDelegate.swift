import ArtistHubCore
import UIKit

final class ListViewDelegate: NSObject, UICollectionViewDelegate {

    weak var collectionView: UICollectionView?
    weak var dataSource: UICollectionViewDiffableDataSource<Section, Artist>?

    private let imageManager: ImageManagerType
    private let persistentClient: PersistenceClientType = PersistenceClientFactory().makePersistenceClient()

    // MARK: - Initialization

    init(imageManager: ImageManagerType) {
        self.imageManager = imageManager
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
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
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }

        imageManager.cancelImage(for: item.avatar)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }

        guard var snapshot = dataSource?.snapshot() else {
            return
        }

        let updatedItem = item.copy(isFavorite: !item.isFavorite)
        _ = persistentClient.saveOrUpdate(object: updatedItem)

        snapshot.insertItems([updatedItem], afterItem: item)
        snapshot.deleteItems([item])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

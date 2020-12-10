import ArtistHubCore
import UIKit

enum Section: Int {
    case main = 40
}

final class ListViewDataSource: UICollectionViewDiffableDataSource<Section, Artist> {

    private let persistentClient: PersistenceClientType = PersistenceClientFactory().makePersistenceClient()

    // MARK: - Initialization

    init(collectionView: UICollectionView) {
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: "cell")
        super.init(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ListViewCell
            cell?.avatarImageView.image = UIImage.Images.placeholder
            cell?.nameLabel.text = model.name
            cell?.usernameLabel.text = model.username
            cell?.descriptionLabel.text = model.description
            cell?.dateLabel.text = model.date
            cell?.followersLabel.text = model.followers
            cell?.favouriteButton.isSelected = model.isFavorite

            return cell
        }
    }

    // MARK: - Public

    func applyChange(with data: [Artist]) {
        let mappedData: [Artist] = data.map { artist in
            let persistentStoreResult = persistentClient.fetch(request: artist.fetchRequest())
            let persistentObject = try? persistentStoreResult.get().first
            guard let stored = persistentObject else {
                return artist
            }

            return artist.copy(isFavorite: stored.isFavorite)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mappedData)
        apply(snapshot, animatingDifferences: true)
    }
}

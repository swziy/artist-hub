import ArtistHubCore
import UIKit

enum Section: Int {
    case main = 40
}

final class ListViewDataSource: UICollectionViewDiffableDataSource<Section, Artist> {

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

            return cell
        }
    }

    // MARK: - Public

    func applyChange(with data: [Artist]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        apply(snapshot, animatingDifferences: true)
    }
}

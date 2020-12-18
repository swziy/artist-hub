import ArtistHubCore
import UIKit

final class ListViewDataSource {

    private(set) lazy var dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
        [unowned self] (collectionView, indexPath, identifier) -> UICollectionViewCell? in
        guard let model = self.data[identifier] else {
            return nil
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section.main.rawValue, for: indexPath) as? ListViewCell
        cell?.avatarImageView.image = UIImage.Images.placeholder
        cell?.nameLabel.text = model.name
        cell?.usernameLabel.text = model.username
        cell?.descriptionLabel.text = model.description
        cell?.dateLabel.text = model.date
        cell?.followersLabel.text = model.followers
        cell?.favouriteButton.isSelected = model.isFavorite
        cell?.favouriteButton.addTarget(
            self,
            action: #selector(ListViewDataSource.didTapFavoriteButton),
            for: .touchUpInside
        )

        return cell
    }

    private(set) var data: [Int: Artist] = [:]

    private var selectedTab: Int = 0
    private let collectionView: UICollectionView
    private let listViewRepository: ListViewRepositoryType

    // MARK: - Initialization

    init(collectionView: UICollectionView, listViewRepository: ListViewRepositoryType) {
        self.collectionView = collectionView
        self.listViewRepository = listViewRepository
        self.collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: Section.main.cellIdentifier)
        self.collectionView.register(
            ListViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Section.main.headerIdentifier
        )
        setUpSupplementaryItemProvider()
    }

    func applyChange(with data: [Artist]) {
        self.data = Dictionary(uniqueKeysWithValues: data.map { ($0.id, $0) } )

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data.map { $0.id } )
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Action

    @objc private func didChangeSegmentedControl(sender: UISegmentedControl) {
        selectedTab = sender.selectedSegmentIndex
        let ids = sender.selectedSegmentIndex == 0 ? allIds() : favoriteIds()
        animatedDifference(with: ids)
    }

    @objc private func didTapFavoriteButton(sender: UIButton) {
        let point = collectionView.convert(sender.center, from: sender.superview)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }

        guard let identifier = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        guard let item = data[identifier] else {
            return
        }

        let copy = item.copy(isFavorite: !item.isFavorite)
        guard listViewRepository.update(copy) else {
            return
        }

        data[identifier] = copy

        UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve) {
            sender.isSelected = copy.isFavorite
        }

        if selectedTab == 1 {
            animatedDifference(with: favoriteIds())
        }
    }

    // MARK: - Private

    private func setUpSupplementaryItemProvider() {
        dataSource.supplementaryViewProvider = {
            [unowned self] (collectionView, identifier, indexPath) -> UICollectionViewCell? in
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: Section.main.headerIdentifier,
                for: indexPath
            ) as? ListViewHeader

            header?.segmentedControl.addTarget(
                self,
                action: #selector(ListViewDataSource.didChangeSegmentedControl),
                for: .valueChanged)

            return header
        }
    }

    private func allIds() -> [Int] {
        data.values.sorted { $0.id < $1.id }.map { $0.id }
    }

    private func favoriteIds() -> [Int] {
        data.values.sorted { $0.id < $1.id }.filter { $0.isFavorite }.map { $0.id }
    }

    private func animatedDifference(with ids: [Int]) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(ids)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

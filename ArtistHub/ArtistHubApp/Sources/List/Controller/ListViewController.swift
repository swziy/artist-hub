import UIKit
import ArtistHubCore
import ArtistHubUserInterface

protocol ListViewControllerDelegate: AnyObject {
    func didSelectDetail(with id: String)
}

final class ListViewController: UIViewController, ListViewControllerType {

    enum Section: Int {
        case main = 40
    }

    weak var delegate: ListViewControllerDelegate?
    private lazy var listView = ListView()
    private lazy var dataSource = makeDataSource()

    // MARK: - Lifecycle

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artist Hub"

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ListViewController.userDidTap))
        view.addGestureRecognizer(tapGesture)

        setUpData()
    }

    // MARK: - Actions

    @objc private func userDidTap() {
        var snapshot = dataSource.snapshot()
        let newIdentifier = snapshot.itemIdentifiers.first!.id == 0 ? Section.main.rawValue : snapshot.itemIdentifiers.first!.id + 1
        snapshot.insertItems([Artist.sample(id: newIdentifier)], beforeItem: snapshot.itemIdentifiers.first!)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Private

    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Artist> {
        listView.collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: "cell")
        return UICollectionViewDiffableDataSource(collectionView: listView.collectionView) {
            (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ListViewCell
            cell?.avatarImageView.image = UIImage(named: model.avatar)
            cell?.nameLabel.text = model.name
            cell?.usernameLabel.text = model.username
            cell?.descriptionLabel.text = model.description
            cell?.dateLabel.text = model.date
            cell?.followersLabel.text = model.followers

            return cell
        }
    }

    private func setUpData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<Section.main.rawValue).map { Artist.sample(id: $0) })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

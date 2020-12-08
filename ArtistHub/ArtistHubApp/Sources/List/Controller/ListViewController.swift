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
    private let artistListService: ArtistListServiceType

    // MARK: - Initialization

    init(artistListService: ArtistListServiceType) {
        self.artistListService = artistListService
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artist Hub"
        loadData()
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

    private func loadData() {
        artistListService.getArtistList { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.display(list: data)
            case .failure(let error):
                // TODO: Handle error!
                print("// TODO: handle error \(error)")
            }
        }
    }

    private func display(list: [Artist]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Required initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

import UIKit
import ArtistHubCore
import ArtistHubUserInterface

protocol ListViewControllerDelegate: AnyObject {
    func didSelectDetail(with id: String)
}

final class ListViewController: UIViewController, ListViewControllerType {

    weak var delegate: ListViewControllerDelegate?

    private lazy var listView = ListView()
    private lazy var listViewDataSource = ListViewDataSource(collectionView: listView.collectionView)

    private let artistListService: ArtistListServiceType
    private let listViewDelegate: ListViewDelegate

    // MARK: - Initialization

    init(artistListService: ArtistListServiceType, imageManager: ImageManagerType) {
        self.artistListService = artistListService
        self.listViewDelegate = ListViewDelegate(imageManager: imageManager)
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artist Hub"
        setUpList()
        loadData()
    }

    // MARK: - Private

    private func setUpList() {
        listViewDelegate.collectionView = listView.collectionView
        listViewDelegate.dataSource = listViewDataSource

        listView.collectionView.delegate = listViewDelegate
    }

    private func loadData() {
        artistListService.getArtistList { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.listViewDataSource.applyChange(with: data)
            case .failure(let error):
                // TODO: Handle error!
                print("// TODO: handle error \(error)")
            }
        }
    }

    // MARK: - Required initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

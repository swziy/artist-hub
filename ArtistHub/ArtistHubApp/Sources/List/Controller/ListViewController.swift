import ArtistHubCore
import ArtistHubUserInterface
import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func didSelectDetail(with id: String)
}

final class ListViewController: UIViewController, ListViewControllerType {

    weak var delegate: ListViewControllerDelegate?

    private lazy var listView = ListView()
    private lazy var listViewDataSource = ListViewDataSource(collectionView: listView.collectionView, listViewRepository: listViewRepository)

    private let listViewDelegate: ListViewDelegate
    private let listViewRepository: ListViewRepositoryType

    // MARK: - Initialization

    init(listViewRepository: ListViewRepositoryType, imageManager: ImageManagerType) {
        self.listViewRepository = listViewRepository
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
        listViewDelegate.listViewDataSource = listViewDataSource

        listView.collectionView.delegate = listViewDelegate
    }

    private func loadData() {
        listView.showActivityIndicator()
        listViewRepository.load { [weak self] result in
            self?.listView.hideActivityIndicator()
            self?.handle(result: result)
        }
    }

    private func handle(result: Result<[Artist], ListViewError>) {
        switch result {
        case .success(let data):
            listViewDataSource.applyChange(with: data)
        case .failure(let error):
            // TODO: Handle error!
            print("// TODO: handle error \(error)")
        }
    }

    // MARK: - Required initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

import ArtistHubUserInterface
import UIKit

final class ListView: UIView {

    let collectionView = UICollectionView(layout: ListViewLayoutConfigurator.makeLayout, style: .init { collectionView in
        collectionView.backgroundColor = UIColor.Fill.lightGray
    })

    var retryButton: UIButton {
        errorView.retryButton
    }

    private let errorView = ErrorView()
    private let activityIndicator = UIActivityIndicatorView(style: .init {
        $0.style = .medium
        $0.color = UIColor.Fill.accent
    })

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setUpViews()
        setUpLayout()
    }

    // MARK: - Public

    func showActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func showErrorView() {
        errorView.isHidden = false
    }

    func hideErrorView() {
        errorView.isHidden = true
    }

    // MARK: - Subviews

    private func setUpViews() {
        addSubview(collectionView)
        addSubview(errorView)
        collectionView.addSubview(activityIndicator)
    }

    // MARK: - Layout

    private func setUpLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive  = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive  = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive  = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  = true

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48.0).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    // MARK: - Required init

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

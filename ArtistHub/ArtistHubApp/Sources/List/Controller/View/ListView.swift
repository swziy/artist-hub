import UIKit

final class ListView: UIView {

    let collectionView = UICollectionView(layout: ListViewLayoutConfigurator.makeLayout, style: .init { collectionView in
        collectionView.backgroundColor = UIColor.Fill.lightGray
    })

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

    // MARK: - Subviews

    private func setUpViews() {
        addSubview(collectionView)
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
    }

    // MARK: - Required init

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

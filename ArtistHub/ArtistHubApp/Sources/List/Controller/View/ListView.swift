import UIKit

final class ListView: UIView {

    let collectionView = UICollectionView(layout: ListViewLayoutConfigurator.makeLayout, style: .init { collectionView in
        collectionView.backgroundColor = UIColor.Fill.lightGray
    })

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setUpViews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func setUpViews() {
        addSubview(collectionView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive  = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive  = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive  = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  = true
    }

    // MARK: - Required init

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

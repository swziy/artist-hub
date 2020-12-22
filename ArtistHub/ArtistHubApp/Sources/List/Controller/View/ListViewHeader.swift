import UIKit

final class ListViewHeader: UICollectionViewCell {

    let segmentedControl = UISegmentedControl(style: .init {
        $0.insertSegment(withTitle: "All", at: 0, animated: false)
        $0.insertSegment(withTitle: "Favorite", at: 1, animated: false)
        $0.selectedSegmentIndex = 0
    })

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        contentView.addSubview(segmentedControl)
    }

    // MARK: - Layout

    private func setUpLayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
    }

    // MARK: - Required init

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

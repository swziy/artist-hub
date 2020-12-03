import UIKit

extension Stylable where Self: UICollectionView {

    public init(frame: CGRect = .zero, layout: UICollectionViewLayout, style: Style<Self>) {
        self.init(frame: frame, collectionViewLayout: layout)
        apply(style)
    }
}

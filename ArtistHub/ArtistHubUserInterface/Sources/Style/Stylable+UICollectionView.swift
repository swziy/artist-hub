import UIKit

public extension Stylable where Self: UICollectionView {

    init(frame: CGRect = .zero, layout: UICollectionViewLayout, style: Style<Self>) {
        self.init(frame: frame, collectionViewLayout: layout)
        apply(style)
    }
}

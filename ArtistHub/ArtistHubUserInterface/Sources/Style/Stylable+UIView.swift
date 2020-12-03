import UIKit

public extension Stylable where Self: UIView {

    init(frame: CGRect = .zero, style: Style<Self>) {
        self.init(frame: frame)
        apply(style)
    }

    internal func apply(_ style: Style<Self>) {
        style.apply(to: self)
    }
}

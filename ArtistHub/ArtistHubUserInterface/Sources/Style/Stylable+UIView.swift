import UIKit

extension Stylable where Self: UIView {

    public init(frame: CGRect = .zero, style: Style<Self>) {
        self.init(frame: frame)
        apply(style)
    }

    func apply(_ style: Style<Self>) {
        style.apply(to: self)
    }
}

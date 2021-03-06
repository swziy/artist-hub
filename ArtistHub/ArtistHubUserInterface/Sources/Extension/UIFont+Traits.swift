import UIKit

public extension UIFont {

    var bold: UIFont {
        withTraits(traits: .traitBold)
    }

    var italic: UIFont {
        withTraits(traits: .traitItalic)
    }

    // MARK: - Private

    private func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        UIFont(descriptor: fontDescriptor.withSymbolicTraits(traits)!, size: 0)
    }
}

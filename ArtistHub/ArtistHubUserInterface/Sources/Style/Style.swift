import UIKit

public struct Style<View> {

    public typealias StyleDefinition = (View) -> Void
    private let definition: (View) -> Void

    // MARK: - Initialization

    public init(_ definition: @escaping StyleDefinition) {
        self.definition = definition
    }

    func apply(to view: View) {
        definition(view)
    }
}

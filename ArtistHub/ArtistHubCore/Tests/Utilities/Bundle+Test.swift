import Foundation

extension Bundle {

    static var test: Bundle {
        allBundles.first { $0.bundlePath.hasSuffix(".xctest") }!
    }
}

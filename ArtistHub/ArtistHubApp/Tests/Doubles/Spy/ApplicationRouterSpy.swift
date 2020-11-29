import UIKit
@testable import ArtistHubApp

class ApplicationRouterSpy: ApplicationRouterType {

    private(set) var routeToMainScreenInvoked: [UIWindow] = []

    // MARK: - ApplicationRouterType

    func routeToMainScreen(in window: UIWindow) {
        routeToMainScreenInvoked.append(window)
    }
}

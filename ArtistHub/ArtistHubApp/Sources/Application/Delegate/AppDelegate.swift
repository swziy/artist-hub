import ArtistHubUserInterface
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var router: ApplicationRouterType
    var window: UIWindow?

    // MARK: - Initialization

    override init() {
        let navigationController = UINavigationController()
        router = ApplicationRouter(navigationController: navigationController)
    }

    // MARK: - UIApplicationDelegate

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow.default

        if let window = window {
            router.routeToMainScreen(in: window)
        }
        
        return true
    }
}

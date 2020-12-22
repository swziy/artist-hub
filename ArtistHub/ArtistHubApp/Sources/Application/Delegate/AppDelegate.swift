import ArtistHubUserInterface
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {

    var router: ApplicationRouterType
    var window: UIWindow?
    var navigationBarAppearanceConfigurator: NavigationBarAppearanceConfiguratorType

    // MARK: - Initialization

    override init() {
        router = ApplicationRouter(
            navigationController: UINavigationController.default,
            listRouterFactory: ListRouterFactory()
        )
        navigationBarAppearanceConfigurator = NavigationBarAppearanceConfigurator()
    }

    // MARK: - UIApplicationDelegate

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        navigationBarAppearanceConfigurator.configure()

        window = UIWindow.default

        if let window = window {
            router.routeToMainScreen(in: window)
        }

        return true
    }
}

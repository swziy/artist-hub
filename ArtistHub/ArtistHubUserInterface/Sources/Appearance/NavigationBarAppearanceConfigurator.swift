import UIKit

public struct NavigationBarAppearanceConfigurator: NavigationBarAppearanceConfiguratorType {

    // MARK: - Initialization

    public init() {}

    // MARK: - NavigationBarAppearanceConfiguratorType

    public func configure() {
        UINavigationBar.appearance().standardAppearance = appearanceForStandardNavigationBar()
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceForLargeNavigationBar()
    }

    // MARK: - Private

    private func appearanceForStandardNavigationBar() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.Fill.accent
        titleAttributes(for: appearance)

        return appearance
    }

    private func appearanceForLargeNavigationBar() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.Fill.lightGray
        titleAttributes(for: appearance)

        return appearance
    }

    private func titleAttributes(for appearance: UINavigationBarAppearance) {
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
    }
}

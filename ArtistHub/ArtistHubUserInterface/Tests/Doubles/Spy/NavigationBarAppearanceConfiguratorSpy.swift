import ArtistHubUserInterface

class NavigationBarAppearanceConfiguratorSpy: NavigationBarAppearanceConfiguratorType {

    private(set) var invokedConfigure: Int = 0

    // MARK: - NavigationBarAppearanceConfiguratorType

    func configure() {
        invokedConfigure += 1
    }
}

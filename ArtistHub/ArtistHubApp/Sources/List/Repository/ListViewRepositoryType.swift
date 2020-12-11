import ArtistHubCore

enum ListViewError: Error {
    case loadError
}

protocol ListViewRepositoryType {
    func load(with completion: @escaping (Result<[Artist], ListViewError>) -> Void)
    func update(_ artist: Artist) -> Bool
}

import ArtistHubCore

enum ListViewError: Error {
    case loadError
}

protocol ListViewRepositoryType {
    var data: [Int: Artist] { get }
    func load(with completion: @escaping (Result<[Artist], ListViewError>) -> Void)
    func update(_ artist: Artist) -> Bool
    func allIds() -> [Int]
    func favoriteIds() -> [Int]
}

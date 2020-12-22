import ArtistHubCore
import Foundation

final class ListViewRepository: ListViewRepositoryType {

    private let artistListService: ArtistListServiceType
    private let persistentClient: PersistenceClientType

    // MARK: - Initialization

    init(artistListService: ArtistListServiceType, persistentClient: PersistenceClientType) {
        self.artistListService = artistListService
        self.persistentClient = persistentClient
    }

    // MARK: - ListViewRepositoryType

    private(set) var data: [Int: Artist] = [:]

    func load(with completion: @escaping (Result<[Artist], ListViewError>) -> Void) {
        artistListService.getArtistList { [persistentClient] result in
            let mappedResult = result
                .mapError { error -> ListViewError in
                    .loadError
                }
                .flatMap { artists -> Result<[Artist], ListViewError> in
                    let updatedObjects = artists.map { artist -> Artist in
                        guard let stored = try? persistentClient.fetch(request: artist.fetchRequest()).get().first else {
                            return artist
                        }

                        return artist.copy(isFavorite: stored.isFavorite)
                    }

                    return .success(updatedObjects)
                }

            if let data = try? mappedResult.get() {
                self.data = Dictionary(uniqueKeysWithValues: data.map { ($0.id, $0) } )
            }

            completion(mappedResult)
        }
    }

    func update(_ artist: Artist) -> Bool {
        if (try? persistentClient.saveOrUpdate(object: artist).get()) != nil {
            data[artist.id] = artist
            return true
        }

        return false
    }

    func allIds() -> [Int] {
        data.values.sorted { $0.id < $1.id }.map { $0.id }
    }

    func favoriteIds() -> [Int] {
        data.values.sorted { $0.id < $1.id }.filter { $0.isFavorite }.map { $0.id }
    }
}

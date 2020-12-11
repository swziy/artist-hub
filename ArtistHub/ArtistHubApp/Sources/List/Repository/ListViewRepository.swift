import ArtistHubCore

final class ListViewRepository: ListViewRepositoryType {

    private let artistListService: ArtistListServiceType
    private let persistentClient: PersistenceClientType

    // MARK: - Initialization

    init(artistListService: ArtistListServiceType, persistentClient: PersistenceClientType) {
        self.artistListService = artistListService
        self.persistentClient = persistentClient
    }

    // MARK: - ListViewRepositoryType

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

            completion(mappedResult)
        }
    }

    func update(_ artist: Artist) -> Bool {
        (try? persistentClient.saveOrUpdate(object: artist).get()) != nil
    }
}

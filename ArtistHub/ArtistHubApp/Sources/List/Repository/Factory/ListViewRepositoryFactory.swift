import ArtistHubCore

struct ListViewRepositoryFactory {

    func makeListViewRepository() -> ListViewRepositoryType {
        let artistListService = ArtistListServiceFactory().makeArtistListService()
        let persistenceClient = PersistenceClientFactory().makePersistenceClient()

        return ListViewRepository(artistListService: artistListService, persistentClient: persistenceClient)
    }
}

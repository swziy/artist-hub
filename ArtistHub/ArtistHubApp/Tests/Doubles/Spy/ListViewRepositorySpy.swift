import ArtistHubCore
@testable import ArtistHubApp

class ListViewRepositorySpy: ListViewRepositoryType {

    var stubbedLoadResult: Result<[Artist], ListViewError> = .success(.testData)
    var stubbedUpdateResult = true
    private(set) var invokedLoadWith: [(Result<[Artist], ListViewError>) -> Void] = []
    private(set) var invokedUpdateWith: [Artist] = []

    // MARK: - ListViewRepositoryType

    var data: [Int: Artist] {
        let data = (try? stubbedLoadResult.get()) ?? []

        return Dictionary(uniqueKeysWithValues: data.map { ($0.id, $0) })
    }

    func load(with completion: @escaping (Result<[Artist], ListViewError>) -> Void) {
        invokedLoadWith.append(completion)
        completion(stubbedLoadResult)
    }

    func update(_ artist: Artist) -> Bool {
        invokedUpdateWith.append(artist)
        return stubbedUpdateResult
    }

    func allIds() -> [Int] {
        let data = (try? stubbedLoadResult.get()) ?? []

        return data.map { $0.id }
    }

    func favoriteIds() -> [Int] {
        let data = (try? stubbedLoadResult.get()) ?? []

        return data.filter { $0.isFavorite }.map { $0.id }
    }
}

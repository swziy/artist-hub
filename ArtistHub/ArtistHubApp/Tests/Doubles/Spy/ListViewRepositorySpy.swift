import ArtistHubCore
@testable import ArtistHubApp

class ListViewRepositorySpy: ListViewRepositoryType {

    var stubbedLoadResult: Result<[Artist], ListViewError> = .success(.testData)
    var stubbedUpdateResult = true
    private(set) var invokedLoadWith: [(Result<[Artist], ListViewError>) -> Void] = []
    private(set) var invokedUpdateWith: [Artist] = []

    // MARK: - ListViewRepositoryType

    func load(with completion: @escaping (Result<[Artist], ListViewError>) -> Void) {
        invokedLoadWith.append(completion)
        completion(stubbedLoadResult)
    }

    func update(_ artist: Artist) -> Bool {
        invokedUpdateWith.append(artist)
        return stubbedUpdateResult
    }
}

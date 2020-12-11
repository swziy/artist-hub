import ArtistHubCore
@testable import ArtistHubApp

class ListViewRepositoryStub: ListViewRepositoryType {

    var stubbedLoadResult: Result<[Artist], ListViewError> = .success(.testData)
    var stubbedUpdateResult = true

    // MARK: - ListViewRepositoryType

    func load(with completion: @escaping (Result<[Artist], ListViewError>) -> Void) {
        completion(stubbedLoadResult)
    }

    func update(_ artist: Artist) -> Bool {
        stubbedUpdateResult
    }
}

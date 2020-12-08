import ArtistHubCore

struct ArtistListServiceStub: ArtistListServiceType {

    var stubbedResult: Result<[Artist], ApiError> = .success(.testData)

    // MARK: - ArtistListServiceType

    func getArtistList(with completion: @escaping (Result<[Artist], ApiError>) -> Void) {
        completion(stubbedResult)
    }
}

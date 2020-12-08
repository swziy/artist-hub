public protocol ArtistListServiceType {
    func getArtistList(with completion: @escaping (Result<[Artist], ApiError>) -> Void)
}

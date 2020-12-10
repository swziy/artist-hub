import CoreData

extension ArtistEntity: DomainConvertibleType {

    public func domain() -> Artist {
        .init(id: Int(artistId), avatar: "", name: "", username: "", date: "", description: "", followers: "", isFavorite: isFavorite)
    }
}

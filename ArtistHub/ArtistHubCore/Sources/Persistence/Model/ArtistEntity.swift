import CoreData

@objc(ArtistEntity)
public final class ArtistEntity: NSManagedObject {
    @NSManaged public var artistId: Int16
    @NSManaged public var isFavorite: Bool
}

extension ArtistEntity: Identifiable {}

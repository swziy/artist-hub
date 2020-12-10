import CoreData

public protocol EntityConvertibleType {
    associatedtype Entity: NSManagedObject, DomainConvertibleType

    func update(_ entity: Entity)
    func fetchRequest() -> NSFetchRequest<Entity>
}

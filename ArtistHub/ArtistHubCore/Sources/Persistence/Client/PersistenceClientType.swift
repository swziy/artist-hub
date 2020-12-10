import CoreData

public protocol PersistenceClientType {
    func fetch<T: DomainConvertibleType>(request: NSFetchRequest<T>) -> Result<[T.Domain], PersistenceError>
    func saveOrUpdate<T: EntityConvertibleType>(object: T) -> Result<Void, PersistenceError> where T == T.Entity.Domain
}

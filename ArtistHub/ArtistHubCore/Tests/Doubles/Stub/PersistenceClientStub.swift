import ArtistHubCore
import CoreData

class PersistenceClientStub<ObjectType: DomainConvertibleType>: PersistenceClientType {

    var stubbedFetchResult: Result<[ObjectType.Domain], PersistenceError> = .failure(.storeLoadError)
    var stubbedSaveOrUpdateResult: Result<(), PersistenceError> = .success(())

    // MARK: - PersistenceClientType

    func fetch<T: DomainConvertibleType>(request: CoreData.NSFetchRequest<T>) -> Result<[T.Domain], PersistenceError> {
        stubbedFetchResult.map { $0 as! [T.Domain] }
    }

    func saveOrUpdate<T: EntityConvertibleType>(object: T) -> Result<(), PersistenceError> where T == T.Entity.Domain {
        stubbedSaveOrUpdateResult
    }
}

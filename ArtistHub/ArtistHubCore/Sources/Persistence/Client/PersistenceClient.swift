import CoreData

final class PersistenceClient: PersistenceClientType {

    private let containerFactory: PersistentContainerFactoryType
    private lazy var container = try? containerFactory.makePersistentContainer().get()

    // MARK: - Initialization

    init(containerFactory: PersistentContainerFactoryType) {
        self.containerFactory = containerFactory
    }

    // MARK: - PersistenceClientType

    func fetch<T: DomainConvertibleType>(request: NSFetchRequest<T>) -> Result<[T.Domain], PersistenceError> {
        guard let result = try? container?.viewContext.fetch(request) else {
            return .failure(.operationError)
        }

        return .success(result.map { $0.domain() })
    }

    func saveOrUpdate<T: EntityConvertibleType>(object: T) -> Result<Void, PersistenceError> where T.Entity.Domain == T {
        guard let context = container?.viewContext else {
            return .failure(.operationError)
        }

        let storedEntity = try? context.fetch(object.fetchRequest()).first
        let entity = storedEntity ?? T.Entity(context: context)
        object.update(entity)

        do {
            try context.save()
            return .success(())
        } catch {
            return .failure(.operationError)
        }
    }
}

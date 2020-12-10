import CoreData

struct PersistentContainerFactory: PersistentContainerFactoryType {

    private static var container: NSPersistentContainer?

    // MARK: - PersistentContainerFactoryType

    func makePersistentContainer() -> Result<NSPersistentContainer, PersistenceError> {
        if let container = PersistentContainerFactory.container {
            return .success(container)
        }

        guard let model = NSManagedObjectModel.mergedModel(from: [Bundle.main]) else {
            return .failure(.storeLoadError)
        }

        let container = NSPersistentContainer(name: "MainDataModel", managedObjectModel: model)

        var loadError: Error?
        container.loadPersistentStores { description, error in
            loadError = error
        }

        if loadError != nil {
            return .failure(.storeLoadError)
        }

        PersistentContainerFactory.container = container

        return .success(container)
    }
}

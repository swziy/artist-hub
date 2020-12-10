import CoreData
@testable import ArtistHubCore

class PersistentContainerFactoryStub: PersistentContainerFactoryType {

    lazy var stubbedContainer: NSPersistentContainerStub = {
        let container = NSPersistentContainerStub(name: "MainDataModel", managedObjectModel: PersistentContainerFactoryStub.model)

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, _ in }

        return container
    }()

    lazy var stubbedResult: Result<NSPersistentContainer, PersistenceError>  = .success(stubbedContainer)
    private static let model = NSManagedObjectModel.mergedModel(from: [.test])!

    // MARK: - PersistentContainerFactoryType

    func makePersistentContainer() -> Result<NSPersistentContainer, PersistenceError> {
        stubbedResult
    }
}

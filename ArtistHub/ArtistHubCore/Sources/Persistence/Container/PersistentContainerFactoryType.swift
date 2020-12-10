import CoreData

protocol PersistentContainerFactoryType {
    func makePersistentContainer() -> Result<NSPersistentContainer, PersistenceError>
}

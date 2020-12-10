import CoreData

class NSPersistentContainerStub: NSPersistentContainer {

    var stubbedViewContext: NSManagedObjectContext?

    override var viewContext: NSManagedObjectContext {
        if stubbedViewContext != nil {
            return stubbedViewContext!
        }

        return super.viewContext
    }
}

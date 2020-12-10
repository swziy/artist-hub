import CoreData

class NSManagedContextStub: NSManagedObjectContext {

    override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        throw NSError(domain: "NSManagedContextStub - fetch error", code: -1)
    }

    override func save() throws {
        throw NSError(domain: "NSManagedContextStub - save error", code: -1)
    }
}

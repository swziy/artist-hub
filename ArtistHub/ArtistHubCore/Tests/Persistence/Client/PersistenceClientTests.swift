import CoreData
import XCTest
@testable import ArtistHubCore

class PersistenceClientTests: XCTestCase {

    var containerFactoryStub: PersistentContainerFactoryStub!
    var sut: PersistenceClient!

    override func setUp() {
        super.setUp()
        containerFactoryStub = PersistentContainerFactoryStub()
        sut = PersistenceClient(containerFactory: containerFactoryStub)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        containerFactoryStub = nil
    }

    func test_whenFetchThrowsAnError_shouldReturnError() {
        containerFactoryStub.stubbedContainer.stubbedViewContext = NSManagedContextStub(concurrencyType: .mainQueueConcurrencyType)
        let result = sut.fetch(request: Artist.testData(with: 1).fetchRequest())

        XCTAssertEqual(result, .failure(.operationError))
    }

    func test_whenContainerIsNotAvailable_shouldReturnError() {
        containerFactoryStub.stubbedResult = .failure(.storeLoadError)
        let result = sut.fetch(request: Artist.testData(with: 1).fetchRequest())

        XCTAssertEqual(result, .failure(.operationError))
    }

    func test_whenFetchDataForEmptyDatabase_shouldReturnSuccess() {
        let result = sut.fetch(request: Artist.testData(with: 1).fetchRequest())

        XCTAssertEqual(result, .success([]))
    }

    func test_whenFetchDataIsPresent_shouldReturnSuccess() {
        let container = containerFactoryStub.makePersistentContainer()
        let context = try! container.get().viewContext

        var inserted: [Bool] = []
        for i in 1...5 {
            let entity = ArtistEntity(context: context)
            entity.artistId = Int16(i)
            entity.isFavorite = true

            inserted.append(entity.isInserted)
        }
        try! context.save()

        XCTAssertEqual(inserted, [true, true, true, true, true])

        let result = sut.fetch(request: Artist.testData(with: 3).fetchRequest())
        let resultEntity = try! result.get().first!

        XCTAssertEqual(resultEntity.id, 3)
        XCTAssertEqual(resultEntity.isFavorite, true)
    }

    func test_whenDataAreStored_shouldAppearInAContext() {
        let container = containerFactoryStub.makePersistentContainer()
        let context = try! container.get().viewContext

        let result = sut.saveOrUpdate(object: Artist.testData(with: 12, favorite: true))
        if case .failure = result {
            XCTFail("Error storing object")
        }

        let entities: [ArtistEntity] = try! context.fetch(Artist.testData(with: 12).fetchRequest())

        XCTAssertEqual(entities.count, 1)
        XCTAssertEqual(entities.first!.artistId, 12)
        XCTAssertEqual(entities.first!.isFavorite, true)
    }

    func test_whenMultipleObjectsAreStored_shouldAppearInAContext() {
        let firstResult = sut.saveOrUpdate(object: Artist.testData(with: 17, favorite: true))
        if case .failure(let error) = firstResult {
            XCTFail("Error storing object: \(error)")
        }

        let secondResult = sut.saveOrUpdate(object: Artist.testData(with: 34, favorite: false))
        if case .failure = secondResult {
            XCTFail("Error storing object")
        }

        let container = containerFactoryStub.makePersistentContainer()
        let context = try! container.get().viewContext

        let request = NSFetchRequest<ArtistEntity>(entityName: "ArtistEntity")
        let entities: [ArtistEntity] = try! context.fetch(request)

        XCTAssertEqual(entities.count, 2)
        XCTAssertEqual(entities[0].artistId, 34)
        XCTAssertEqual(entities[0].isFavorite, false)
        XCTAssertEqual(entities[1].artistId, 17)
        XCTAssertEqual(entities[1].isFavorite, true)
    }

    func test_whenUpdatingExistingObject_shouldHaveUpdatedValues() {
        let container = containerFactoryStub.makePersistentContainer()
        let context = try! container.get().viewContext

        let firstResult = sut.saveOrUpdate(object: Artist.testData(with: 17, favorite: true))
        if case .failure(let error) = firstResult {
            XCTFail("Error storing object: \(error)")
        }

        var request = NSFetchRequest<ArtistEntity>(entityName: "ArtistEntity")
        var entities: [ArtistEntity] = try! context.fetch(request)

        XCTAssertEqual(entities.count, 1)
        XCTAssertEqual(entities[0].artistId, 17)
        XCTAssertEqual(entities[0].isFavorite, true)

        let secondResult = sut.saveOrUpdate(object: Artist.testData(with: 17, favorite: false))
        if case .failure = secondResult {
            XCTFail("Error storing object")
        }

        request = NSFetchRequest<ArtistEntity>(entityName: "ArtistEntity")
        entities = try! context.fetch(request)

        XCTAssertEqual(entities.count, 1)
        XCTAssertEqual(entities[0].artistId, 17)
        XCTAssertEqual(entities[0].isFavorite, false)
    }

    func test_whenSaveInContextFails_shouldReturnOperationError() {
        containerFactoryStub.stubbedContainer.stubbedViewContext = NSManagedContextStub(concurrencyType: .mainQueueConcurrencyType)
        let result = sut.saveOrUpdate(object: Artist.testData(with: 1))
        if case .success = result {
            XCTFail("Save should fail")
        }
    }

    func test_whenContainerIsNotLoaded_shouldReturnOperationError() {
        containerFactoryStub.stubbedResult = .failure(.storeLoadError)
        let result = sut.saveOrUpdate(object: Artist.testData(with: 1))
        if case .success = result {
            XCTFail("Save should fail")
        }
    }
}

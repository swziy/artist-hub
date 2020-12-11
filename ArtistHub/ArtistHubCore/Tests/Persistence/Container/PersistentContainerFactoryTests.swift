import CoreData
import XCTest
@testable import ArtistHubCore

class PersistentContainerFactoryTests: XCTestCase {

    var sut: PersistentContainerFactory!

    override func setUp() {
        super.setUp()
        sut = .init()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_whenMakeContainerMultipleTimes_shouldBeSameInstance() {
        let first = try! sut.makePersistentContainer().get()
        let second = try! sut.makePersistentContainer().get()

        XCTAssertTrue(first === second)
    }

    func test_whenMakeContainer_shouldBeLoadedSuccessfully() {
        let result = sut.makePersistentContainer()
        if case Result.failure = result {
            XCTFail("Failed to load persistent store")
        }
    }

    func test_whenMakeContainer_shouldHaveCorrectName() {
        let result = sut.makePersistentContainer()
        let store = try! result.get()

        XCTAssertEqual(store.name, "MainDataModel")
    }

    func test_whenMakeContainer_shouldBePersistentType() {
        let result = sut.makePersistentContainer()
        let store = try! result.get()
        let descriptions = store.persistentStoreDescriptions

        XCTAssertEqual(descriptions.count, 1)
        XCTAssertEqual(descriptions.first!.type, NSSQLiteStoreType)
    }
}

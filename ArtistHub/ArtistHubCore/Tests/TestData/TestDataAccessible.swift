protocol TestDataAccessible {
    associatedtype TestDataType

    static var testData: TestDataType { get }
}

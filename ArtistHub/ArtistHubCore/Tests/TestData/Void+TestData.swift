extension Never: TestDataAccessible {

    static var testData: Never {
        fatalError("Never can't have test data")
    }
}

public final class Task<T> {

    let id: UUID
    let execution: () -> T
    let completion: (T) -> Void

    // MARK: - Initialization

    public init(id: UUID = UUID(), execution: @escaping () -> T, completion: @escaping (T) -> Void) {
        self.id = id
        self.execution = execution
        self.completion = completion
    }

    func execute() {
        let result = execution()
        completion(result)
    }
}

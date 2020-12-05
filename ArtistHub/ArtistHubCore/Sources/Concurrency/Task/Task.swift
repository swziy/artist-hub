public class Task {

    let id: UUID
    let execution: () -> Void
    let completion: () -> Void

    // MARK: - Initialization

    public init(id: UUID = UUID(), execution: @escaping () -> Void, completion: @escaping () -> Void) {
        self.id = id
        self.execution = execution
        self.completion = completion
    }

    func execute() {
        execution()
        completion()
    }
}

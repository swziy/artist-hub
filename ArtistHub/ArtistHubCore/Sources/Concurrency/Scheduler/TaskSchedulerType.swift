public protocol TaskSchedulerType {
    associatedtype TaskResult

    func schedule(task: Task<TaskResult>)
    func schedule(group: [Task<TaskResult>], notifyQueue: DispatchQueue, completion: @escaping () -> Void)
}

// MARK: - Type erased TaskSchedulerType

public struct AnyTaskScheduler<T>: TaskSchedulerType {
    public typealias TaskResult = T

    private let _scheduleTask: (Task<T>) -> Void
    private let _scheduleGroup: ([Task<T>], DispatchQueue, @escaping () -> Void) -> Void

    public init<S: TaskSchedulerType>(_ scheduler: S) where S.TaskResult == T {
        self._scheduleTask = scheduler.schedule(task:)
        self._scheduleGroup = scheduler.schedule(group:notifyQueue:completion:)
    }

    public func schedule(task: Task<T>) {
        _scheduleTask(task)
    }

    public func schedule(group: [Task<T>], notifyQueue: DispatchQueue, completion: @escaping () -> Void) {
        _scheduleGroup(group, notifyQueue, completion)
    }
}

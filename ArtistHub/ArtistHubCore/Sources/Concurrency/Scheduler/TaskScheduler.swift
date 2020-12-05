public final class TaskScheduler: TaskSchedulerType {

    private var activeTasks: [Task] = []
    private var pendingTasks: [Task] = []
    private let maxConcurrentTasks: Int
    private let workDispatcher: DispatcherType
    private let syncQueue = DispatchQueue(label: "task.scheduler.sync.queue")

    // MARK: - Initialization

    public init(maxConcurrentTasks: Int = 10,
                workDispatcher: DispatcherType) {
        self.maxConcurrentTasks = maxConcurrentTasks
        self.workDispatcher = workDispatcher
    }

    // MARK: - TaskSchedulerType

    public func schedule(task: Task) {
        syncQueue.sync {
            self.pendingTasks.append(task)
            self.schedulePendingTasks()
        }
    }

    public func schedule(group: [Task],
                         notifyQueue: DispatchQueue = .main,
                         completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        group.forEach { _ in dispatchGroup.enter() }

        dispatchGroup.notify(queue: notifyQueue, execute: completion)

        let wrappedGroup = group.map { orginalTask in
            Task(id: orginalTask.id, execution: orginalTask.execution) {
                orginalTask.completion()
                dispatchGroup.leave()
            }
        }

        wrappedGroup.forEach(schedule)
    }

    public func schedule(list: Task...,
                         notifyQueue: DispatchQueue = .main,
                         completion: @escaping () -> Void) {
        schedule(group: list, notifyQueue: notifyQueue, completion: completion)
    }

    // MARK: - Private

    private func schedulePendingTasks() {
        guard activeTasks.count < maxConcurrentTasks else {
            return
        }

        guard pendingTasks.count != 0 else {
            return
        }

        let task = dequeuePendingTask()

        workDispatcher.dispatch {
            task.execute()

            self.syncQueue.async {
                self.removeActiveTask(with: task.id)
                self.schedulePendingTasks()
            }
        }
    }

    private func dequeuePendingTask() -> Task {
        let pendingTask = pendingTasks[0]
        pendingTasks.removeFirst()
        activeTasks.append(pendingTask)

        return pendingTask
    }

    private func removeActiveTask(with id: UUID) {
        activeTasks.removeAll { $0.id == id }
    }
}

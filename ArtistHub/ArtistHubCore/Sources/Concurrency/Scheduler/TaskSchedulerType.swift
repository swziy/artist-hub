public protocol TaskSchedulerType {
    func schedule(task: Task)
    func schedule(group: [Task], notifyQueue: DispatchQueue, completion: @escaping () -> Void)
    func schedule(list: Task..., notifyQueue: DispatchQueue, completion: @escaping () -> Void)
}

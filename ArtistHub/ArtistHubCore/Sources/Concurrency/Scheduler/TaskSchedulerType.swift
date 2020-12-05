public protocol TaskSchedulerType {
    func schedule(task: Task)
    func schedule(group: [Task], notifyQuque: DispatchQueue, completion: @escaping () -> Void)
    func schedule(list: Task..., notifyQuque: DispatchQueue, completion: @escaping () -> Void)
}

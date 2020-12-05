public protocol DispatcherType {
    func dispatch(_ work: @escaping () -> Void)
}

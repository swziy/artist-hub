public protocol DomainConvertibleType {
    associatedtype Domain

    func domain() -> Domain
}

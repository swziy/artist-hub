final class DetailsRouterFactory: DetailsRouterFactoryType {

    // MARK: - DetailsRouterFactoryType

    func makeDetailsRouter() -> DetailsRouterType {
        DetailsRouter(controllerFactory: DetailsControllerFactory())
    }
}

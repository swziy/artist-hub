final class ListRouterFactory: ListRouterFactoryType {

    // MARK: - ListRouterFactoryType

    func makeListRouter() -> ListRouterType {
        ListRouter(controllerFactory: ListControllerFactory(),
                   detailsRouterFactory: DetailsRouterFactory())
    }
}

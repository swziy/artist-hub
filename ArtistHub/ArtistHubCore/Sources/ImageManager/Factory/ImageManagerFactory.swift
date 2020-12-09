public struct ImageManagerFactory {

    // MARK: - Initialization

    public init() {}

    // MARK: - Public

    public func makeImageManager() -> ImageManagerType {
        let imageService = ImageServiceFactory().makeImageService()
        let imageCache = ImageCacheFactory().makeImageCache()

        return ImageManager(imageService: imageService, imageCache: imageCache)
    }
}

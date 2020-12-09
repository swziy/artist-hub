struct ImageCacheFactory: ImageCacheFactoryType {

    // MARK: - ImageCacheFactoryType

    func makeImageCache() -> ImageCacheType {
        ImageCache.shared
    }
}

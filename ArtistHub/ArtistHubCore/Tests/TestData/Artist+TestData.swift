import ArtistHubCore

extension Artist {

    static func testData(with id: Int) -> Artist {
        .init(
            id: id,
            avatar: "vincent",
            name: "Vincent van Gogh - \(id)",
            username: "@gogh",
            date: "2w",
            description: description(for: id),
            followers: "2.1M Followers",
            isFavorite: false
        )
    }

    static func testData(with id: Int, favorite: Bool) -> Artist {
        .init(
            id: id,
            avatar: "vincent",
            name: "Vincent van Gogh - \(id)",
            username: "@gogh",
            date: "2w",
            description: description(for: id),
            followers: "2.1M Followers",
            isFavorite: favorite
        )
    }

    // MARK: - Private

    private static func description(for id: Int) -> String {
        let defaultDescription = "Dutch post-impressionist painter who is among the most famous and influential figures in the history"
        if id % 2 == 0 {
            return "\(defaultDescription). \(defaultDescription)"
        }

        return defaultDescription
    }
}

extension Array: TestDataAccessible where Element == Artist {

    static var testData: [Artist] {
        [
            .testData(with: 1),
            .testData(with: 2),
            .testData(with: 3),
            .testData(with: 4),
            .testData(with: 5),
        ]
    }
}

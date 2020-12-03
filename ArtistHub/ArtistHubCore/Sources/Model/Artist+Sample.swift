extension Artist {

    public static func sample(id: Int) -> Self {
        .init(
            id: id,
            avatar: "vincent",
            name: "Vincent van Gogh - \(id)",
            username: "@gogh",
            date: "2w",
            description: description(for: id),
            followers: "2.1M Followers"
        )
    }

    // MARK: - Pirvate

    static func description(for id: Int) -> String {
        let defaultDescription = "Dutch post-impressionist painter who is among the most famous and influential figures in the history"
        if id % 2 == 0 {
            return "\(defaultDescription). \(defaultDescription)"
        }

        return defaultDescription
    }
}

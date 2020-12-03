public struct Artist: Equatable, Hashable {

    public let id: Int
    public let avatar: String
    public let name: String
    public let username: String
    public let date: String
    public let description: String
    public let followers: String

    public init(id: Int, avatar: String, name: String,
                username: String, date: String, description: String,
                followers: String) {
        self.id = id
        self.avatar = avatar
        self.name = name
        self.username = username
        self.date = date
        self.description = description
        self.followers = followers
    }
}

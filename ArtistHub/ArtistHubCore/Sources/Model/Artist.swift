import CoreData

public struct Artist: Equatable, Hashable, Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case avatar
        case name
        case username
        case date
        case description
        case followers
    }

    public let id: Int
    public let avatar: String
    public let name: String
    public let username: String
    public let date: String
    public let description: String
    public let followers: String
    public private(set) var isFavorite: Bool = false

    // MARK: - Initialization

    public init(id: Int, avatar: String, name: String,
                username: String, date: String, description: String,
                followers: String, isFavorite: Bool) {
        self.id = id
        self.avatar = avatar
        self.name = name
        self.username = username
        self.date = date
        self.description = description
        self.followers = followers
        self.isFavorite = isFavorite
    }
}

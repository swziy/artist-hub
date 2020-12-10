extension Artist {

    public func copy(isFavorite: Bool) -> Artist {
        .init(id: id, avatar: avatar, name: name,
              username: username, date: date, description: description,
              followers: followers, isFavorite: isFavorite)
    }
}

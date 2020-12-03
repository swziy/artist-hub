import UIKit

final class ListViewCell: UICollectionViewCell {

    let avatarImageView = UIImageView(style: .init {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 36.0, height: 36.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        $0.layer.mask = maskLayer
    })

    let nameLabel = UILabel(style: .init {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor.black
    })

    let usernameLabel = UILabel(style: .init {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light).italic
        $0.textColor = UIColor.Fill.gray
    })

    let descriptionLabel = UILabel(style: .init {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor.black
        $0.numberOfLines = 0
    })

    let dateLabel = UILabel(style: .init {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light).italic
        $0.textColor = UIColor.Fill.gray
    })

    let followersLabel = UILabel(style: .init {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light).italic
        $0.textColor = UIColor.Fill.gray
    })

    let favouriteButton = UIButton(style: .init {
        $0.setImage(UIImage(named: "heart_outline"), for: .normal)
        $0.setImage(UIImage(named: "heart_filled"), for: .selected)
    })

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        setUpViews()
        setUpLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowOpacity = 0.1
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10.0).cgPath
    }

    // MARK: - Subviews

    private func setUpViews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(followersLabel)
        contentView.addSubview(favouriteButton)
    }

    // MARK: - Layout

    private func setUpLayout() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 36.0),
            avatarImageView.heightAnchor.constraint(equalToConstant: 36.0),

            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),

            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8.0),
            usernameLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: 12.0),

            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            dateLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0),

            followersLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16.0),
            followersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            followersLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),

            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            favouriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0)
        ])
    }

    // MARK: - Required init

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

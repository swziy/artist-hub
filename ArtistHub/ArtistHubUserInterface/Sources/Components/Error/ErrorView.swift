import UIKit

public final class ErrorView: UIView {

    public let retryButton = UIButton(style: .init {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = .init(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 10.0
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 10
        $0.setTitle("Retry", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.setTitleColor(UIColor.Fill.gray, for: .highlighted)
    })

    private let imageView = UIImageView(style: .init {
        $0.image = UIImage(named: "error")
    })

    private let messageLabel = UILabel(style: .init {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor.black
        $0.text = "Something went wrong..."
    })

    private let stackView = UIStackView(style: .init {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 16.0
    })

    // MARK: - Initialization

    public init() {
        super.init(frame: .zero)
        setUpViews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func setUpViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(retryButton)
    }

    // MARK: - Layout

    private func setUpLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            retryButton.widthAnchor.constraint(equalToConstant: 96.0),
            retryButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }

    // MARK: - Required init

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

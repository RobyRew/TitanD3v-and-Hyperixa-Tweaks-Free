import UIKit

class WhatsNewCardView: UIView {
    private let titleText: String
    private let titleFont: UIFont
    private let descriptionText: String
    private let descriptionFont: UIFont
    private let icon: UIImage?
    private let iconTintColor: UIColor?

    init(titleText: String,
         titleFont: UIFont,
         descriptionText: String,
         descriptionFont: UIFont,
         icon: UIImage?,
         iconTintColor: UIColor?) {
        self.titleText = titleText
        self.titleFont = titleFont
        self.descriptionText = descriptionText
        self.descriptionFont = descriptionFont
        self.icon = icon
        self.iconTintColor = iconTintColor

        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = icon
        imageView.tintColor = iconTintColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleText
        label.numberOfLines = 0
        label.textColor = .label
        label.font = titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = descriptionText
        label.numberOfLines = 0
        label.textColor = .tertiaryLabel
        label.font = descriptionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setup() {
        setupViewsHierarchy()
        setupViewsContraints()
    }

    private func setupViewsHierarchy() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }

    private func setupViewsContraints() {
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true

        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

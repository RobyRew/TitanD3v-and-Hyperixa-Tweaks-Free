import UIKit

public class WhatsNewBaseView: UIView {
    public init(content: WhatsNewContent.Base) {
        viewContent = content
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewContent: WhatsNewContent.Base

    private lazy var welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = viewContent.title.format.textAlignment
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        if case let .multiline(welcomeText) = viewContent.title.format {
            label.text = welcomeText
        }

        return label
    }()

    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = viewContent.title.text
        label.textColor = viewContent.button.backgroundColor
        label.textAlignment = viewContent.title.format.textAlignment
        label.font = viewContent.title.format.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var cardsListView: WhatsNewCardsListView = {
        let view = WhatsNewCardsListView(items: viewContent.cards)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var continueButton: WhatsNewPrimaryButton = {
        let button = WhatsNewPrimaryButton()
        button.setTitle(viewContent.button.text, for: .normal)
        button.backgroundColor = viewContent.button.backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func setup() {
        setupViewsHierarchy()
        setupViewsContraints()
        setupAdditionalSettings()
    }

    private func setupViewsHierarchy() {
        addSubview(welcomeTitleLabel)
        addSubview(nameTitleLabel)

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(cardsListView)

        addSubview(continueButton)
    }

    private func setupViewsContraints() {
        welcomeTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        welcomeTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        welcomeTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true

        nameTitleLabel.topAnchor.constraint(equalTo: welcomeTitleLabel.bottomAnchor, constant: -4).isActive = true
        nameTitleLabel.leadingAnchor.constraint(equalTo: welcomeTitleLabel.leadingAnchor).isActive = true
        nameTitleLabel.trailingAnchor.constraint(equalTo: welcomeTitleLabel.trailingAnchor).isActive = true

        continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true

        scrollView.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 50).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: nameTitleLabel.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: nameTitleLabel.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -15).isActive = true

        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        cardsListView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardsListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardsListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardsListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupAdditionalSettings() {
        backgroundColor = viewContent.backgroundColor
        continueButton.addTarget(self, action: #selector(didPressedButton), for: .touchUpInside)
    }

    @objc private func didPressedButton() {
        viewContent.button.action?()
    }
}

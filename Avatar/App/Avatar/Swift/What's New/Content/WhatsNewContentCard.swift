import UIKit

public extension WhatsNewContent {
    struct Card {
        public let title: String
        public let titleFont: UIFont
        public let resume: String
        public let resumeFont: UIFont
        public let icon: UIImage?
        public let iconTintColor: UIColor?

        public init(title: String,
                    titleFont: UIFont = .systemFont(ofSize: 18, weight: .bold),
                    resume: String,
                    resumeFont: UIFont = .systemFont(ofSize: 16, weight: .semibold),
                    icon: UIImage?,
                    iconTintColor: UIColor = .black) {
            self.title = title
            self.titleFont = titleFont
            self.resume = resume
            self.resumeFont = resumeFont
            self.icon = icon
            self.iconTintColor = iconTintColor
        }
    }
}

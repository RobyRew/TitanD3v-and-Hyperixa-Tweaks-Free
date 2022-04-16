import UIKit

public extension WhatsNewContent {
    struct Button {
        public let text: String
        public let backgroundColor: UIColor
        public let action: (() -> Void)?

        public init(text: String,
                    backgroundColor: UIColor = .lightGray,
                    action: (() -> Void)? = nil) {
            self.text = text
            self.backgroundColor = backgroundColor
            self.action = action
        }
    }
}

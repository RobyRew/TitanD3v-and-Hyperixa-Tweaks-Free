import UIKit

public extension WhatsNewContent {
    struct Base {
        public let backgroundColor: UIColor
        public let title: WhatsNewContent.Title
        public let cards: [WhatsNewContent.Card]
        public let button: WhatsNewContent.Button

        public init(backgroundColor: UIColor,
                    title: WhatsNewContent.Title,
                    cards: [WhatsNewContent.Card],
                    button: WhatsNewContent.Button) {
            self.backgroundColor = backgroundColor
            self.title = title
            self.cards = cards
            self.button = button
        }
    }
}

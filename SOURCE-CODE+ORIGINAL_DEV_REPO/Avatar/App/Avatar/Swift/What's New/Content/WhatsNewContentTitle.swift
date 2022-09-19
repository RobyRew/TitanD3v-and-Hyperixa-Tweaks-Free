import UIKit

public extension WhatsNewContent {
    struct Title {
        public let format: WhatsNewContent.Title.Format
        public let text: String

        public init(format: WhatsNewContent.Title.Format, text: String) {
            self.format = format
            self.text = text
        }
    }
}

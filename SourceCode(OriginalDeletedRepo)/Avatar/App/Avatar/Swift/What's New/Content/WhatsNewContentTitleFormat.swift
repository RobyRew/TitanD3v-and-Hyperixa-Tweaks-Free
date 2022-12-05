import UIKit

public extension WhatsNewContent.Title {
    enum Format: Equatable {
        case oneline
        case multiline(welcomeText: String)

        var textAlignment: NSTextAlignment {
            switch self {
            case .oneline: return .center
            case .multiline: return .left
            }
        }

        var font: UIFont {
            switch self {
            case .oneline: return .systemFont(ofSize: 32, weight: .bold)
            case .multiline: return .systemFont(ofSize: 32, weight: .heavy)
            }
        }
    }
}

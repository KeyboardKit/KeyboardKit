import Foundation
import KeyboardKit

extension EmojiCategory {
    
    var title: String {
        switch self {
        case .frequents: return "FREQUENTLY USED"
        case .smileys: return "SMILEYS & PEOPLE"
        case .animals: return "ANIMALS & NATURE"
        case .foods: return "FOODS & DRINKS"
        case .activities: return "ACTIVITY"
        case .travels: return "TRAVEL & PLACES"
        case .objects: return "OBJECTS"
        case .symbols: return "SYMBOLS"
        case .flags: return "FLAGS"
        }
    }
}

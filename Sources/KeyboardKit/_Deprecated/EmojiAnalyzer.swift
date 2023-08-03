import Foundation

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public protocol EmojiAnalyzer {}

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public extension EmojiAnalyzer {

    /**
     Whether or not the string contains an emoji.
     */
    func containsEmoji(_ string: String) -> Bool {
        string.containsEmoji
    }

    /**
     Whether or not the string only contains emojis.
     */
    func containsOnlyEmojis(_ string: String) -> Bool {
        string.containsOnlyEmojis
    }

    /**
     Extract all emoji characters from the string.
     */
    func emojis(in string: String) -> [Character] {
        string.emojis
    }

    /**
     Extract all emoji scalars from the string.
     */
    func emojiScalars(in string: String) -> [UnicodeScalar] {
        string.emojiScalars
    }

    /**
     Extract all emojis in the string.
     */
    func emojiString(in string: String) -> String {
        string.emojiString
    }

    /**
     Whether or not a character is a an emoji.
     */
    func isEmoji(_ char: Character) -> Bool {
        char.isEmoji
    }

    /**
     Whether or not the character consists of unicodeScalars
     that will be merged into an emoji.
     */
    func isCombinedEmoji(_ char: Character) -> Bool {
        char.isCombinedEmoji
    }

    /**
     Whether or not the character is a "simple emoji", which
     is a single scalar that is presented as an emoji.
     */
    func isSimpleEmoji(_ char: Character) -> Bool {
        char.isSimpleEmoji
    }

    /**
     Whether or not the string is a single emoji.
     */
    func isSingleEmoji(_ string: String) -> Bool {
        string.isSingleEmoji
    }
}

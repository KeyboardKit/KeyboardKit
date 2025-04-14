import Foundation
import SwiftUI

public extension Emoji {

    @available(*, deprecated, renamed: "matches(_:in:)")
    func matches(
        _ query: String,
        for locale: Locale
    ) -> Bool {
        matches(query, in: locale)
    }
}

extension EmojiCategory: CaseIterable {}

public extension EmojiCategory {
    
    @available(*, deprecated, renamed: "standardCategories")
    static var standard: [EmojiCategory] {
        standardCategories
    }
    
    @available(*, deprecated, renamed: "resetEmojis(for:)")
    static func resetEmojis(
        in category: PersistedCategory
    ) {
        resetEmojis(for: category)
    }
    
    @available(*, deprecated, message: "EmojiCategory no longer implements CaseIterable.")
    static var allCases: [EmojiCategory] {
        [
            .smileysAndPeople,
            .animalsAndNature,
            .foodAndDrink,
            .activity,
            .travelAndPlaces,
            .objects,
            .symbols,
            .flags
        ]
    }
    
    @available(*, deprecated, renamed: "standard")
    static var standardWithoutFrequent: [EmojiCategory] { standard }
}

public extension Collection where Element == Emoji {

    @available(*, deprecated, renamed: "matches(_:in:)")
    func matching(
        _ query: String,
        for locale: Locale
    ) -> [Emoji] {
        matching(query, in: locale)
    }
}

public extension Localizable {

    @available(*, deprecated, renamed: "localizedName(in:bundle:)")
    func localizedName(
        for locale: Locale = .current,
        in bundle: Bundle
    ) -> String {
        let key = localizationKey
        let localeBundle = bundle.bundle(for: locale) ?? bundle
        return NSLocalizedString(key, bundle: localeBundle, comment: "")
    }

    @available(*, deprecated, renamed: "localizedName(in:)")
    func localizedName(
        for locale: Locale = .current
    ) -> String {
        localizedName(in: locale)
    }
}

public extension EmojiVersion {
    
    @available(*, deprecated, renamed: "v16_0")
    static var v15_2: Self { .v16_0 }
}

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
    
    @available(*, deprecated, renamed: "GridSectionTitleParameters")
    typealias GridSectionParameters = GridSectionTitleParameters
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

@available(*, deprecated, renamed: "EmojiGridScrollView")
public typealias EmojiScrollGrid = EmojiGridScrollView

public extension EmojiGrid {
    
    @available(*, deprecated, message: "The emoji grid no longer takes a persisted category.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        persistedCategory: EmojiCategory.PersistedCategory,
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            section: section,
            item: item
        )
    }
    
    @available(*, deprecated, message: "section is renamed to sectionTitle and item to gridItem.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: section,
            gridItem: item
        )
    }
    
    @available(*, deprecated, message: "Use either the emojis or the categories initializer, not this one which has both.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji]?,
        categories: [EmojiCategory]?,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        if let emojis {
            self.init(
                axis: axis,
                emojis: emojis,
                selection: selection,
                geometryProxy: geometryProxy,
                action: action,
                categoryEmojis: categoryEmojis,
                sectionTitle: sectionTitle,
                gridItem: gridItem
            )
        } else {
            self.init(
                axis: axis,
                categories: categories,
                selection: selection,
                geometryProxy: geometryProxy,
                action: action,
                categoryEmojis: categoryEmojis,
                sectionTitle: sectionTitle,
                gridItem: gridItem
            )
        }
    }
}

public extension EmojiGridScrollView {
    
    @available(*, deprecated, message: "The emoji grid no longer takes a persisted category.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        persistedCategory: EmojiCategory.PersistedCategory,
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            section: section,
            item: item
        )
    }
    
    @available(*, deprecated, message: "section is renamed to sectionTitle and item to gridItem.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: section,
            gridItem: item
        )
    }
    
    @available(*, deprecated, message: "Use either the emojis or the categories initializer, not this one which has both.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji]?,
        categories: [EmojiCategory]?,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis ?? [],
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }
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

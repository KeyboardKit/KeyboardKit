//
//  Emoji+KeyboardStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
public extension Emoji {

    /// This style can be used to modify the visual style of
    /// the ``EmojiKeyboard`` component and its nested views.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/emojiKeyboardStyle(_:)``.
    ///
    /// This style has an ``itemSize``, an ``itemFont``, and
    /// an ``itemScaleFactor`` to let us define how an emoji
    /// is best rendered for memory efficiency in a keyboard.
    /// This is needed since the SwiftUI grid only allocates
    /// new cells, but never deallocated them.
    ///
    /// The ``itemSize`` defines the size of each emoji view,
    /// and ``itemFont`` the font to use. Since smaller font
    /// sizes use less memory, an ``itemScaleFactor`` can be
    /// used to smaller emoji views in lower resolution.
    struct KeyboardStyle {

        /// Create an emoji keyboard item style.
        ///
        /// The standard parameter values generates a style that
        /// mimics the standard iPhone portrait style.
        ///
        /// Just omit any parameters or pass in `nil` to use the
        /// standard value, as defined for each parameter.
        ///
        /// - Parameters:
        ///   - rows: The number of keyboard rows, by default `5`.
        ///   - itemSize: The emoji item view size, by default `40`.
        ///   - itemFont: The emoji item view font, by default `.system(size: 33)`.
        ///   - itemScaleFactor: The emoji item view scale factor, by default `1`.
        ///   - horizontalItemSpacing: The horizontal emoji item spacing, by default `10`.
        ///   - verticalPadding: The vertical keyboard padding, by default `5`.
        ///   - verticalItemSpacing: The vertical emoji item spacing, by default `6`.
        ///   - verticalCategoryStackSpacing: The vertical category stack spacing, by default `0`.
        ///   - categoryTitleFont: The category title label font, by default `.system(size: 12)`.
        ///   - categoryTitlePadding: The category title label padding, by default top `2` and bottom `5`.
        ///   - menuAbcFont: The category menu ABC button font, by default `.system(size: 14)`.
        ///   - menuIconSize: The category menu icon size, by default `15`.
        ///   - menuIconFont: The category menu icon font, by default `.system(size: 20, weight: .light)`.
        ///   - menuSpacing: The category menu icon spacing, by default `5`.
        ///   - menuSelectionSize: The category menu selection size, by default `6`.
        ///   - menuSelectionColor: The selected category color, by default `.primary.opacity(0.1)`.
        public init(
            rows: Int? = nil,
            itemSize: Double? = nil,
            itemFont: Font? = nil,
            itemScaleFactor: Double? = nil,
            horizontalItemSpacing: Double? = nil,
            verticalPadding: Double? = nil,
            verticalItemSpacing: Double? = nil,
            verticalCategoryStackSpacing: Double? = nil,
            categoryTitleFont: Font? = nil,
            categoryTitlePadding: EdgeInsets? = nil,
            menuAbcFont: Font? = nil,
            menuIconSize: CGFloat? = nil,
            menuIconFont: Font? = nil,
            menuSpacing: CGFloat? = nil,
            menuSelectionSize: CGFloat? = nil,
            menuSelectionColor: Color? = nil
        ) {
            self.rows = rows ?? 5
            self.itemSize = itemSize ?? 40
            self.itemFont = itemFont ?? .system(size: 33)
            self.itemScaleFactor = itemScaleFactor ?? 1.0
            self.horizontalItemSpacing = horizontalItemSpacing ?? 10
            self.verticalPadding = verticalPadding ?? 5
            self.verticalItemSpacing = verticalItemSpacing ?? 6
            self.verticalCategoryStackSpacing = verticalCategoryStackSpacing ?? 0
            self.categoryTitleFont = categoryTitleFont ?? .system(size: 12)
            self.categoryTitlePadding = categoryTitlePadding ?? .init(top: 2, leading: 0, bottom: 5, trailing: 0)
            self.menuAbcFont = menuAbcFont ?? .system(size: 14)
            self.menuIconSize = menuIconSize ?? 15
            self.menuIconFont = menuIconFont ?? .system(size: 20, weight: .light)
            self.menuSpacing = menuSpacing ?? 5
            self.menuSelectionSize = menuSelectionSize ?? 6
            self.menuSelectionColor = menuSelectionColor ?? .primary.opacity(0.1)
        }

        /// The font to apply to the category title label.
        public var categoryTitleFont: Font

        /// The padding to apply to the category title label.
        public var categoryTitlePadding: EdgeInsets

        /// The horizontal spacing to use.
        public var horizontalItemSpacing: Double

        /// The emoji item view font.
        public var itemFont: Font

        /// The emoji item view scale factor.
        public var itemScaleFactor: Double

        /// The emoji item view size.
        public var itemSize: Double

        /// Double number of rows to use in the keyboard.
        public var rows: Int

        /// The category menu ABC font.
        public var menuAbcFont: Font

        /// The category menu icon font.
        public var menuIconFont: Font

        /// The category menu icon size.
        public var menuIconSize: Double

        /// The category menu icon spacing.
        public var menuSpacing: Double

        /// The category menu selection size.
        public var menuSelectionSize: Double

        /// The color to apply to the selected category.
        public var menuSelectionColor: Color

        /// The total keyboard height.
        public var totalHeight: Double { Double(rows) * itemSize }

        /// The vertical padding of the keyboard.
        public var verticalPadding: CGFloat

        /// The vertical category spacing to use.
        public var verticalCategoryStackSpacing: CGFloat

        /// The vertical spacing to use.
        public var verticalItemSpacing: CGFloat
    }
}

public extension Emoji.KeyboardStyle {

    /// This typealias defines an emoji keyboard style builder.
    typealias Builder = (KeyboardContext) -> Self

    /// A standard iPhone style.
    static var standardPhone: Self {
        standardPhone(rows: 5)
    }

    /// A standard iPhone style with custom parameters.
    static func standardPhone(rows: Int) -> Self {
        .init(rows: rows)
    }
}

public extension View {

    /// Apply a ``Emoji/KeyboardStyle``.
    ///
    /// Use the builder-based modifier if you need to adjust
    /// the style based on the keyboard context.
    ///
    /// > Important: Make sure to use memory optimized style
    /// for all devices if the keyboard uses a lot of memory,
    /// e.g. if you load a huge ML model into memory.
    func emojiKeyboardStyle(
        _ style: Emoji.KeyboardStyle
    ) -> some View {
        self.environment(\.emojiKeyboardStyle, { _ in style })
    }

    /// Apply a ``Emoji/KeyboardStyle`` builder.
    ///
    /// Instead of injecting a specific style, this modifier
    /// lets you inject a style builder that can be provided
    /// with the arguments it needs to build a dynamic style.
    ///
    /// If you don't apply a custom style builder, the style
    /// will default to a memory optimized style for iPhones
    /// and a standard style for iPads.
    ///
    /// > Important: Make sure to use memory optimized style
    /// for all devices if the keyboard uses a lot of memory,
    /// e.g. if you load a huge ML model into memory.
    func emojiKeyboardStyle(
        builder: @escaping Emoji.KeyboardStyle.Builder
    ) -> some View {
        self.environment(\.emojiKeyboardStyle, builder)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Emoji/KeyboardStyle`` builder.
    @Entry var emojiKeyboardStyle: Emoji
        .KeyboardStyle.Builder = {
            return { context in
                if context.deviceTypeForKeyboard == .phone {
                    return .optimized(for: context)
                }
                return .standard(for: context)
            }
        }()
}

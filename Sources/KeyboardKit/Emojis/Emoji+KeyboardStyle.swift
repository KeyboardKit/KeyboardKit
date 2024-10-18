//
//  Emoji+KeyboardStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
public extension Emoji {


    /// This style can be used to modify the visual style of the
    /// ``EmojiKeyboard`` component and its nested views.
    ///
    /// You can apply the style by using the view style modifier
    /// ``SwiftUICore/View/emojiKeyboardStyle(_:)``.
    ///
    /// The style has both an ``itemSize``, an ``itemFont``, and
    /// an ``itemScaleFactor`` to define how emojis are rendered
    /// for most memory efficiency, since Swift allocates memory
    /// for each emoji without releasing it right away.
    ///
    /// The ``itemSize`` defines how big an emoji view should be,
    /// e.g. within a grid, while the ``itemFont`` defines which
    /// font to use. Since smaller fonts require less memory, an
    /// ``itemScaleFactor`` can be used with a smaller font size
    /// to draw more memory efficient emojis in lower resolution.
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

    /// Apply an ``Emoji/KeyboardStyle``.
    func emojiKeyboardStyle(
        _ style: Emoji.KeyboardStyle
    ) -> some View {
        self.environment(\.emojiKeyboardStyle, style)
    }
}

private extension Emoji.KeyboardStyle {

    struct Key: EnvironmentKey {
        static var defaultValue: Emoji.KeyboardStyle {
            .standardPhone
        }
    }
}

public extension EnvironmentValues {

    var emojiKeyboardStyle: Emoji.KeyboardStyle {
        get { self [Emoji.KeyboardStyle.Key.self] }
        set { self [Emoji.KeyboardStyle.Key.self] = newValue }
    }
}

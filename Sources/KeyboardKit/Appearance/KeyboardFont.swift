//
//  KeyboardFont.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-30.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This struct represents a font to be used in the keyboard.

 This type makes it possible to use fonts in `Codable` types.
 */
public struct KeyboardFont: Codable, Equatable {

    public init(
        _ type: FontType,
        _ weight: FontWeight? = nil
    ) {
        self.type = type
        self.weight = weight
    }

    public var type: FontType
    public var weight: FontWeight?
}

public extension KeyboardFont {

    typealias FontType = KeyboardFontType
    typealias FontWeight = KeyboardFontWeight

    static var body: Self { .init(.body) }
    static var callout: Self { .init(.callout) }
    static var caption: Self { .init(.caption) }
    static var caption2: Self { .init(.caption2) }
    static var footnote: Self { .init(.footnote) }
    static var headline: Self { .init(.headline) }
    static var largeTitle: Self { .init(.largeTitle) }
    static var subheadline: Self { .init(.subheadline) }
    static var title: Self { .init(.title) }
    static var title2: Self { .init(.title2) }
    static var title3: Self { .init(.title3) }

    static func body(weight: FontWeight) -> Self { .init(.body, weight) }
    static func callout(weight: FontWeight) -> Self { .init(.callout, weight) }
    static func caption(weight: FontWeight) -> Self { .init(.caption, weight) }
    static func caption2(weight: FontWeight) -> Self { .init(.caption2, weight) }
    static func footnote(weight: FontWeight) -> Self { .init(.footnote, weight) }
    static func headline(weight: FontWeight) -> Self { .init(.headline, weight) }
    static func largeTitle(weight: FontWeight) -> Self { .init(.largeTitle, weight) }
    static func subheadline(weight: FontWeight) -> Self { .init(.subheadline, weight) }
    static func title(weight: FontWeight) -> Self { .init(.title, weight) }
    static func title2(weight: FontWeight) -> Self { .init(.title2, weight) }
    static func title3(weight: FontWeight) -> Self { .init(.title3, weight) }

    static func custom(_ name: String, fixedSize: CGFloat) -> Self { .init(.customFixed(name, size: fixedSize)) }
    static func custom(_ name: String, fixedSize: CGFloat, weight: FontWeight) -> Self { .init(.customFixed(name, size: fixedSize), weight) }
    static func custom(_ name: String, size: CGFloat) -> Self { .init(.custom(name, size: size)) }
    static func custom(_ name: String, size: CGFloat, weight: FontWeight) -> Self { .init(.custom(name, size: size), weight) }

    static func system(size: CGFloat) -> Self { .init(.system(size: size)) }
    static func system(size: CGFloat, weight: FontWeight) -> Self { .init(.system(size: size), weight) }

    func weight(_ weight: FontWeight) -> Self { .init(type, weight) }

    /// Get the native font for the font style.
    var font: Font {
        if let weight {
            return type.font.weight(weight.fontWeight)
        } else {
            return type.font
        }
    }
}

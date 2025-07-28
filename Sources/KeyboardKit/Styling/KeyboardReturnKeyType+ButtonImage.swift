//
//  KeyboardReturnKeyType+ButtonImage.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-17.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard.ReturnKeyType {

    /// The standard button image for a certain locale.
    ///
    /// TODO: Implement missing icons in KeyboardKit 10.
    func standardButtonImage(
        for context: KeyboardContext
    ) -> Image? {
        let locale = context.locale
        let isLiquid = context.isLiquidGlassEnabled
        switch self {
        case .done: return isLiquid ? .keyboardDone : nil
        case .go: return isLiquid ? .keyboardGo(for: locale) : nil
        case .join: return isLiquid ? .keyboardJoin(for: locale) : nil
        case .next: return .keyboardNext(for: locale)
        case .newLine: return .keyboardNewline(for: locale)
        case .search: return isLiquid ? .keyboardSearch : nil
        case .return: return isLiquid ? .keyboardNewline(for: locale) : nil
        default: break
        }
        return nil
    }

    @available(*, deprecated, message: "Use the context-based function.")
    func standardButtonImage(
        for locale: Locale
    ) -> Image? {
        switch self {
        case .newLine: .keyboardNewline(for: locale)
        default: nil
        }
    }
}

#Preview {

    struct Preview: View {

        let context = KeyboardContext()

        var body: some View {
            List {
                ForEach(Keyboard.ReturnKeyType.allCases) {
                    preview(for: $0)
                }
            }
        }

        @ViewBuilder
        func preview(for type: Keyboard.ReturnKeyType) -> some View {
            if let icon = type.standardButtonImage(for: context) {
                icon
            } else {
                Text(type.standardButtonText(for: context.locale) ?? "-")
            }
        }
    }

    return Preview()
}

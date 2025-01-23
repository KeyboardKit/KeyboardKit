//
//  View+Selection.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-21.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {

    @ViewBuilder
    func selectionBackground(
        isSelected: Bool,
        cornerRadius: Double = 10
    ) -> some View {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            self.background(
                    ContainerRelativeShape()
                        .fill(selectionBackgroundFillStyle(isSelected: isSelected))
                        .aspectRatio(1, contentMode: .fill)
                )
            .containerShape(.rect(cornerRadius: cornerRadius))
        } else {
            self
        }
    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    func selectionBackgroundFillStyle(
        isSelected: Bool
    ) -> AnyShapeStyle {
        #if os(iOS) || os(macOS)
        switch isSelected {
        case true: .init(.selection)
        case false: .init(.clear)
        }
        #else
            .init(.clear)
        #endif
    }
}

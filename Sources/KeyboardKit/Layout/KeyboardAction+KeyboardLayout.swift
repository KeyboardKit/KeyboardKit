//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-07-18.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAction {

    /// Tge standard layout item insets.
    func standardLayoutItem(
        for config: KeyboardLayout.DeviceConfiguration
    ) -> KeyboardLayout.Item {
        .init(
            action: self,
            size: standardLayoutItemSize(for: config),
            alignment: .center,
            edgeInsets: standardLayoutItemInsets(for: config)
        )
    }

    /// Tge standard layout item insets.
    func standardLayoutItemInsets(
        for config: KeyboardLayout.DeviceConfiguration
    ) -> EdgeInsets {
        switch self {
        case .characterMargin, .none: .init(all: 0)
        default: config.buttonInsets
        }
    }

    /// The standard layout item size.
    func standardLayoutItemSize(
        for config: KeyboardLayout.DeviceConfiguration
    ) -> KeyboardLayout.ItemSize {
        .init(
            width: standardLayoutItemSizeWidth(for: config),
            height: standardLayoutItemSizeHeight(for: config)
        )
    }

    /// The standard layout item height.
    func standardLayoutItemSizeHeight(
        for config: KeyboardLayout.DeviceConfiguration
    ) -> Double {
        config.rowHeight
    }

    /// The standard layout item width.
    func standardLayoutItemSizeWidth(
        for config: KeyboardLayout.DeviceConfiguration
    ) -> KeyboardLayout.ItemWidth {
        switch self {
        case .character: .input
        default: .available
        }
    }
}

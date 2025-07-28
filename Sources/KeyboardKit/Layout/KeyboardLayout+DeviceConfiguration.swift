//
//  KeyboardLayout+DeviceConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardLayout {

    /// This type defines layout configs for various devices
    /// and screen orientations.
    struct DeviceConfiguration: Equatable, Sendable {

        /// Create a new layout configuration.
        ///
        /// - Parameters:
        ///   - buttonCornerRadius: The button corner radius.
        ///   - buttonInsets: The button edge insets.
        ///   - rowHeight: The total row height including insets.
        ///   - inputToolbarHeight: The height to use for a topmost input toolbar.
        public init(
            buttonCornerRadius: Double,
            buttonInsets: EdgeInsets,
            rowHeight: Double,
            inputToolbarHeight: Double? = nil
        ) {
            self.buttonCornerRadius = buttonCornerRadius
            self.buttonInsets = buttonInsets
            self.rowHeight = rowHeight
            self.inputToolbarHeight = inputToolbarHeight ?? (0.8 * rowHeight)
        }

        /// The keyboard button corner radius.
        public var buttonCornerRadius: CGFloat

        /// The keyboard button edge insets.
        public var buttonInsets: EdgeInsets

        /// The total row height, including insets.
        public var rowHeight: CGFloat

        /// The height to use for a topmost input toolbar.
        public var inputToolbarHeight: Double
    }
}

public extension KeyboardLayout.DeviceConfiguration {

    // MARK: - Standard Configuration Functions

    /// The standard config for the provided `context`.
    static func standard(
        for context: KeyboardContext
    ) -> Self {
        standard(
            forDevice: context.deviceTypeForKeyboard,
            screenSize: context.screenSize,
            orientation: context.interfaceOrientation,
            liquidGlass: context.isLiquidGlassEnabled
        )
    }

    /// The standard config for a provided device and screen.
    static func standard(
        forDevice device: DeviceType,
        screenSize size: CGSize,
        orientation: InterfaceOrientation,
        liquidGlass: Bool = false
    ) -> Self {
        switch device {
        case .pad: standardPad(
            forScreenSize: size,
            orientation: orientation,
            liquidGlass: liquidGlass)
        default: standardPhone(
            forScreenSize: size,
            orientation: orientation,
            liquidGlass: liquidGlass)
        }
    }

    /// The standard pad config for the provided `screen`.
    static func standardPad(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation,
        liquidGlass: Bool = false
    ) -> Self {
        var config = standardPadRaw(
            forScreenSize: size,
            orientation: orientation,
            liquidGlass: liquidGlass
        )
        guard liquidGlass else { return config }
        config.buttonCornerRadius = 9
        return config
    }

    private static func standardPadRaw(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation,
        liquidGlass: Bool = false
    ) -> Self {
        let isPortrait = orientation.isPortrait
        let isLarge = size.isAtLeastScreenSize(.iPadLargeScreen)
        if isLarge {
            return isPortrait ? .standardPadLarge : .standardPadLargeLandscape
        }
        return isPortrait ? .standardPad : .standardPadLandscape
    }

    /// The standard phone config for the provided `screen`.
    static func standardPhone(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation,
        liquidGlass: Bool = false
    ) -> Self {
        var config = standardPhoneRaw(
            forScreenSize: size,
            orientation: orientation,
            liquidGlass: liquidGlass
        )
        guard liquidGlass else { return config }
        config.buttonCornerRadius = 9
        return config
    }

    private static func standardPhoneRaw(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation,
        liquidGlass: Bool = false
    ) -> Self {
        let isPortrait = orientation.isPortrait
        let isLarge = size.isAtLeastScreenSize(.iPhoneLargeScreen)
        if isLarge {
            return isPortrait ? .standardPhoneLarge : .standardPhoneLargeLandscape
        }
        var config: Self = isPortrait ? .standardPhone : .standardPhoneLandscape
        guard liquidGlass, isPortrait else { return config }
        config.rowHeight += 2
        config.buttonInsets.top -= 0.5
        config.buttonInsets.bottom -= 0.5
        return config
    }


    // MARK: - Standard Configurations

    /// A standard iPad portrait configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPad = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 5, vertical: 5),
        rowHeight: 64.0
    )

    /// A standard iPad landscape configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPadLandscape = Self(
        buttonCornerRadius: 7,
        buttonInsets: .init(horizontal: 7, vertical: 6),
        rowHeight: 86.0
    )

    /// A standard large iPad portrait configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPadLarge = Self(
        buttonCornerRadius: 6,
        buttonInsets: .init(horizontal: 4, vertical: 4),
        rowHeight: 69.0
    )

    /// A standard large iPad landscape configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPadLargeLandscape = Self(
        buttonCornerRadius: 8,
        buttonInsets: .init(horizontal: 7, vertical: 5),
        rowHeight: 88.0
    )

    /// A standard iPhone portrait configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPhone = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 5),
        rowHeight: 54,
        inputToolbarHeight: 54
    )

    /// A standard iPhone landscape configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPhoneLandscape = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 4),
        rowHeight: 40.0,
        inputToolbarHeight: 40.0
    )

    /// A standard large iPhone portrait configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPhoneLarge = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 5),
        rowHeight: 56.0,
        inputToolbarHeight: 56.0
    )

    /// A standard large iPhone Pro landscape configuration.
    ///
    /// TODO: This will become a constant in KeyboardKit 10.
    static var standardPhoneLargeLandscape = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 4),
        rowHeight: 40.0,
        inputToolbarHeight: 40.0
    )
}

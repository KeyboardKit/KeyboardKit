//
//  KeyboardLayout+Configuration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardLayout {

    /// This type defines layout configs for various devices
    /// and screen orientations.
    struct Configuration: Equatable {

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

public extension KeyboardLayout.Configuration {

    // MARK: - Standard Configuration Functions

    /// The standard config for the provided `context`.
    static func standard(
        for context: KeyboardContext
    ) -> Self {
        standard(
            forDevice: context.deviceType,
            screenSize: context.screenSize,
            orientation: context.interfaceOrientation
        )
    }

    /// The standard config for a provided device and screen.
    static func standard(
        forDevice device: DeviceType,
        screenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> Self {
        switch device {
        case .pad: standardPad(forScreenSize: size, orientation: orientation)
        default: standardPhone(forScreenSize: size, orientation: orientation)
        }
    }

    /// The standard pad config for the provided `screen`.
    static func standardPad(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> Self {
        let isPortrait = orientation.isPortrait
        if size.isScreenSize(.iPadProLargeScreenPortrait, withTolerance: 50) {
            return isPortrait ? .standardPadProLarge : .standardPadProLargeLandscape
        }
        return isPortrait ? .standardPad : .standardPadLandscape
    }

    /// The standard phone config for the provided `screen`.
    static func standardPhone(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> Self {
        let isPortrait = orientation.isPortrait
        if size.isEqual(to: .iPhoneProMaxScreenPortrait, withTolerance: 10) {
            return isPortrait ? .standardPhoneProMax : .standardPhoneProMaxLandscape
        }
        return isPortrait ? .standardPhone : .standardPhoneLandscape
    }


    // MARK: - Standard Configuration Heights

    /// The standard iPad portait row height.
    static var standardPadRowHeight: Double { 64.0 }

    /// The standard iPad landscape row height.
    static var standardPadLandscapeRowHeight: Double { 86.0 }

    /// The standard large iPad Pro portait row height.
    static var standardPadProLargeRowHeight: Double { 69.0 }

    /// The standard large iPad Pro landscape row height.
    static var standardPadProLargeLandscapeRowHeight: Double { 88.0 }

    /// The standard iPhone portrait row height.
    static var standardPhoneRowHeight: Double { 54.0 }

    /// The standard iPhone portrait row height.
    static var standardPhoneLandscapeRowHeight: Double { 40.0 }

    /// The standard iPhone Pro Max portrait row height.
    static var standardPhoneProMaxRowHeight: Double { 56.0 }

    /// The standard iPhone Pro Max portrait row height.
    static var standardPhoneProMaxLandscapeRowHeight: Double { 40.0 }


    // MARK: - Standard Configuration Properties

    /// The standard config for an iPad in portait.
    ///
    /// You can set this config to affect the global default.
    static var standardPad = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 5, vertical: 4),
        rowHeight: standardPadRowHeight
    )

    /// The standard config for an iPad in landscape.
    ///
    /// You can set this config to affect the global default.
    static var standardPadLandscape = Self(
        buttonCornerRadius: 7,
        buttonInsets: .init(horizontal: 7, vertical: 6),
        rowHeight: standardPadLandscapeRowHeight
    )

    /// The standard config for large iPad Pros in portrait.
    ///
    /// You can set this config to affect the global default.
    static var standardPadProLarge = Self(
        buttonCornerRadius: 6,
        buttonInsets: .init(horizontal: 4, vertical: 4),
        rowHeight: standardPadProLargeRowHeight
    )

    /// The standard config for large iPad Pros in landscape.
    ///
    /// You can set this config to affect the global default.
    static var standardPadProLargeLandscape = Self(
        buttonCornerRadius: 8,
        buttonInsets: .init(horizontal: 7, vertical: 5),
        rowHeight: standardPadProLargeLandscapeRowHeight
    )

    /// The standard config for an iPhone in portrait.
    ///
    /// You can set this config to affect the global default.
    static var standardPhone = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 6),
        rowHeight: standardPhoneRowHeight,
        inputToolbarHeight: standardPhoneRowHeight
    )

    /// The standard config for an iPhone in landscape.
    ///
    /// You can set this config to affect the global default.
    static var standardPhoneLandscape = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 4),
        rowHeight: standardPhoneLandscapeRowHeight,
        inputToolbarHeight: standardPhoneLandscapeRowHeight
    )

    /// The standard config for iPhone Pro Max in portrait.
    static var standardPhoneProMax = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 5.5),
        rowHeight: standardPhoneProMaxRowHeight,
        inputToolbarHeight: standardPhoneProMaxRowHeight
    )

    /// The standard config for iPhone Pro Max in landscape.
    ///
    /// You can set this config to affect the global default.
    static var standardPhoneProMaxLandscape = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 4),
        rowHeight: standardPhoneProMaxLandscapeRowHeight,
        inputToolbarHeight: standardPhoneProMaxLandscapeRowHeight
    )
}

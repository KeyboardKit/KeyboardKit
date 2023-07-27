//
//  KeyboardLayoutConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This type defines layout configurations for various devices.

 The standard, parameterless configuration can be changed to
 affect the global defaults.
 */
public struct KeyboardLayoutConfiguration: Equatable {

    /**
     Create a new layout configuration.

     - Parameters:
       - buttonCornerRadius: The corner radius of a keyboard button in the keyboard.
       - buttonInsets: The edge insets of a keyboard button in the keyboard.
       - rowHeight: The total height incl. insets, of a row in the keyboard.
    */
    public init(
        buttonCornerRadius: CGFloat,
        buttonInsets: EdgeInsets,
        rowHeight: CGFloat
    ) {
        self.buttonCornerRadius = buttonCornerRadius
        self.buttonInsets = buttonInsets
        self.rowHeight = rowHeight
    }

    /**
     The corner radius of a keyboard button in the keyboard.
     */
    public var buttonCornerRadius: CGFloat

    /**
     The edge insets of a keyboard button in the keyboard.
     */
    public var buttonInsets: EdgeInsets

    /**
     The total height incl. insets, of a row in the keyboard.
     */
    public var rowHeight: CGFloat
}

public extension KeyboardLayoutConfiguration {

    /**
     The standard config for the provided `context`.
     */
    static func standard(
        for context: KeyboardContext
    ) -> KeyboardLayoutConfiguration {
        standard(
            forDevice: context.deviceType,
            screenSize: context.screenSize,
            orientation: context.interfaceOrientation
        )
    }

    /**
     The standard config for the provided device and screen.
     */
    static func standard(
        forDevice device: DeviceType,
        screenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> KeyboardLayoutConfiguration {
        switch device {
        case .pad: return standardPad(forScreenSize: size, orientation: orientation)
        default: return standardPhone(forScreenSize: size, orientation: orientation)
        }
    }

    /**
     The standard pad config for the provided `screen`.
     */
    static func standardPad(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> KeyboardLayoutConfiguration {
        let isPortrait = orientation.isPortrait
        if size.isScreenSize(.iPadProLargeScreenPortrait) {
            return isPortrait ? .standardPadProLarge : .standardPadProLargeLandscape
        }
        return isPortrait ? .standardPad : .standardPadLandscape
    }

    /**
     The standard phone config for the provided `screen`.
     */
    static func standardPhone(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> KeyboardLayoutConfiguration {
        let isPortrait = orientation.isPortrait
        if size.isEqual(to: .iPhoneProMaxScreenPortrait, withTolerance: 10) {
            return isPortrait ? .standardPhoneProMax : .standardPhoneProMaxLandscape
        }
        return isPortrait ? .standardPhone : .standardPhoneLandscape
    }

    /**
     The standard config for an iPad in portait.

     You can change this value to affect the global default.
     */
    static var standardPad = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(6, vertical: 4),
        rowHeight: standardPadRowHeight)

    /**
     The standard iPad portait row height.
     */
    static let standardPadRowHeight = 64.0

    /**
     The standard config for an iPad in landscape.

     You can change this value to affect the global default.
     */
    static var standardPadLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 7,
        buttonInsets: .horizontal(7, vertical: 6),
        rowHeight: standardPadLandscapeRowHeight)

    /**
     The standard iPad landscape row height.
     */
    static let standardPadLandscapeRowHeight = 86.0

    /**
     The standard config for a large iPad Pro in portrait.

     You can change this value to affect the global default.
     */
    static var standardPadProLarge = KeyboardLayoutConfiguration(
        buttonCornerRadius: 6,
        buttonInsets: .horizontal(4, vertical: 4),
        rowHeight: standardPadProLargeRowHeight)

    /**
     The standard large iPad Pro portait row height.
     */
    static let standardPadProLargeRowHeight = 69.0

    /**
     The standard config for a large iPad Pro in landscape.

     You can change this value to affect the global default.
     */
    static var standardPadProLargeLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 8,
        buttonInsets: .horizontal(7, vertical: 5),
        rowHeight: standardPadProLargeLandscapeRowHeight)

    /**
     The standard large iPad Pro landscape row height.
     */
    static let standardPadProLargeLandscapeRowHeight = 88.0

    /**
     The standard config for an iPhone in portrait.

     You can change this value to affect the global default.
     */
    static var standardPhone = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(3, vertical: 6),
        rowHeight: standardPhoneRowHeight)

    /**
     The standard iPhone portrait row height.
     */
    static var standardPhoneRowHeight = 54.0

    /**
     The standard config for an iPhone in landscape.

     You can change this value to affect the global default.
     */
    static var standardPhoneLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(3, vertical: 4),
        rowHeight: standardPhoneLandscapeRowHeight)

    /**
     The standard iPhone portrait row height.
     */
    static var standardPhoneLandscapeRowHeight = 40.0

    /**
     The standard config for an iPhone Pro Max in portrait.

     You can change this value to affect the global default.
     */
    static var standardPhoneProMax = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(3, vertical: 5.5),
        rowHeight: standardPhoneProMaxRowHeight)

    /**
     The standard iPhone Pro Max portrait row height.
     */
    static var standardPhoneProMaxRowHeight = 56.0

    /**
     The standard config for an iPhone Pro Max in landscape.

     You can change this value to affect the global default.
     */
    static var standardPhoneProMaxLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(3, vertical: 4),
        rowHeight: standardPhoneProMaxLandscapeRowHeight)

    /**
     The standard iPhone Pro Max portrait row height.
     */
    static var standardPhoneProMaxLandscapeRowHeight = 40.0
}

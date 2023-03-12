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
 This struct can be used to specify a keyboard configuration
 for e.g. a certain device.
 
 This struct makes it easy to specify how standard keyboards
 are structured in various devices.
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
    static func standard(for context: KeyboardContext) -> KeyboardLayoutConfiguration {
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
            return isPortrait ? .standardPadProLarge : .standardPadLargeProLandscape
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
     */
    static let standardPad = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(6, vertical: 4),
        rowHeight: 64)

    /**
     The standard config for an iPad in landscape.
     */
    static let standardPadLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 7,
        buttonInsets: .horizontal(7, vertical: 6),
        rowHeight: 86)

    /**
     The standard config for a large iPad Pro in portrait.
     */
    static let standardPadProLarge = KeyboardLayoutConfiguration(
        buttonCornerRadius: 6,
        buttonInsets: .horizontal(4, vertical: 4),
        rowHeight: 69)
    
    /**
     The standard config for a large iPad Pro in landscape.
     */
    static let standardPadLargeProLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 8,
        buttonInsets: .horizontal(7, vertical: 5),
        rowHeight: 88)

    /**
     The standard config for an iPhone in portrait.
     */
    static let standardPhone = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(3, vertical: 6),
        rowHeight: 54)
    
    /**
     The standard config for an iPhone in landscape.
     */
    static let standardPhoneLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(3, vertical: 4),
        rowHeight: 40)

    /**
     The standard config for an iPhone Pro Max in portrait.
     */
    static let standardPhoneProMax = KeyboardLayoutConfiguration(
        buttonCornerRadius: 5,
        buttonInsets: .horizontal(3, vertical: 6),
        rowHeight: 58)
    
    /**
     The standard config for an iPhone Pro Max in landscape.
     */
    static let standardPhoneProMaxLandscape = KeyboardLayoutConfiguration
        .standardPhoneLandscape
}

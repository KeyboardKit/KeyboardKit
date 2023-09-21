//
//  KeyboardLayout+Configuration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardLayout {
    
    /**
     This struct defines keyboard layout configs for various
     device types.
     
     The standard parameterless configuration can be changed
     to affect the global defaults.
     */
    struct Configuration: Equatable {
        
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
        
        /// The keyboard button corner radius.
        public var buttonCornerRadius: CGFloat
        
        /// The keyboard button edge insets.
        public var buttonInsets: EdgeInsets
        
        /// The total row height, including insets.
        public var rowHeight: CGFloat
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
        case .pad: return standardPad(forScreenSize: size, orientation: orientation)
        default: return standardPhone(forScreenSize: size, orientation: orientation)
        }
    }

    /// The standard pad config for the provided `screen`.
    static func standardPad(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> Self {
        let isPortrait = orientation.isPortrait
        if size.isScreenSize(.iPadProLargeScreenPortrait) {
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
    static var standardPadRowHeight = 64.0

    /// The standard iPad landscape row height.
    static var standardPadLandscapeRowHeight = 86.0

    /// The standard large iPad Pro portait row height.
    static var standardPadProLargeRowHeight = 69.0

    /// The standard large iPad Pro landscape row height.
    static var standardPadProLargeLandscapeRowHeight = 88.0

    /// The standard iPhone portrait row height.
    static var standardPhoneRowHeight = 54.0

    /// The standard iPhone portrait row height.
    static var standardPhoneLandscapeRowHeight = 40.0

    /// The standard iPhone Pro Max portrait row height.
    static var standardPhoneProMaxRowHeight = 56.0

    /// The standard iPhone Pro Max portrait row height.
    static var standardPhoneProMaxLandscapeRowHeight = 40.0
    
    
    // MARK: - Standard Configuration Properties

    /**
     The standard config for an iPad in portait.

     You can change this value to affect the global default.
     */
    static var standardPad = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 6, vertical: 4),
        rowHeight: standardPadRowHeight)

    /**
     The standard config for an iPad in landscape.

     You can change this value to affect the global default.
     */
    static var standardPadLandscape = Self(
        buttonCornerRadius: 7,
        buttonInsets: .init(horizontal: 7, vertical: 6),
        rowHeight: standardPadLandscapeRowHeight)

    /**
     The standard config for a large iPad Pro in portrait.

     You can change this value to affect the global default.
     */
    static var standardPadProLarge = Self(
        buttonCornerRadius: 6,
        buttonInsets: .init(horizontal: 4, vertical: 4),
        rowHeight: standardPadProLargeRowHeight)

    /**
     The standard config for a large iPad Pro in landscape.

     You can change this value to affect the global default.
     */
    static var standardPadProLargeLandscape = Self(
        buttonCornerRadius: 8,
        buttonInsets: .init(horizontal: 7, vertical: 5),
        rowHeight: standardPadProLargeLandscapeRowHeight)

    /**
     The standard config for an iPhone in portrait.

     You can change this value to affect the global default.
     */
    static var standardPhone = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 6),
        rowHeight: standardPhoneRowHeight)

    /**
     The standard config for an iPhone in landscape.

     You can change this value to affect the global default.
     */
    static var standardPhoneLandscape = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 4),
        rowHeight: standardPhoneLandscapeRowHeight)

    /**
     The standard config for an iPhone Pro Max in portrait.

     You can change this value to affect the global default.
     */
    static var standardPhoneProMax = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 5.5),
        rowHeight: standardPhoneProMaxRowHeight)

    /**
     The standard config for an iPhone Pro Max in landscape.

     You can change this value to affect the global default.
     */
    static var standardPhoneProMaxLandscape = Self(
        buttonCornerRadius: 5,
        buttonInsets: .init(horizontal: 3, vertical: 4),
        rowHeight: standardPhoneProMaxLandscapeRowHeight)
}

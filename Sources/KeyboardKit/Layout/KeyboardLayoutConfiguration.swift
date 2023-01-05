//
//  KeyboardLayoutConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
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
        #if os(iOS)
        standard(
            forDevice: context.deviceType,
            screenSize: context.screenSize,
            orientation: context.interfaceOrientation)
        #else
        .standardPhoneLandscape
        #endif
    }
    
    #if os(iOS)
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
            return isPortrait ? .standardPadLargeProPortrait : .standardPadLargeProLandscape
        } else if size.isScreenSize(.iPadProSmallScreenPortrait) {
            return isPortrait ? .standardPadPortrait : .standardPadLandscape
        }
        return isPortrait ? .standardPadPortrait : .standardPadLandscape
    }
    
    /**
     The standard phone config for the provided `screen`.
     */
    static func standardPhone(
        forScreenSize size: CGSize,
        orientation: InterfaceOrientation
    ) -> KeyboardLayoutConfiguration {
        let isPortrait = orientation.isPortrait
        if size.isScreenSize(.iPhoneProMaxScreenPortrait) {
            return isPortrait ? .standardPhoneProMaxPortrait : .standardPhoneProMaxLandscape
        }
        return isPortrait ? .standardPhonePortrait : .standardPhoneLandscape
    }
    #endif
    
    /**
     The standard config for an iPad in landscape.
     */
    static let standardPadLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 8,
        buttonInsets: .horizontal(7, vertical: 6),
        rowHeight: 86)
    
    /**
     The standard config for an iPad in portait.
     */
    static let standardPadPortrait = KeyboardLayoutConfiguration(
        buttonCornerRadius: 6,
        buttonInsets: .horizontal(6, vertical: 4),
        rowHeight: 64)
    
    /**
     The standard config for a large iPad Pro in landscape.
     */
    static let standardPadLargeProLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 8,
        buttonInsets: .horizontal(7, vertical: 5),
        rowHeight: 88)
    
    /**
     The standard config for a large iPad Pro in portrait.
     */
    static let standardPadLargeProPortrait = KeyboardLayoutConfiguration(
        buttonCornerRadius: 6,
        buttonInsets: .horizontal(4, vertical: 4),
        rowHeight: 69)
    
    /**
     The standard config for an iPhone in landscape.
     */
    static let standardPhoneLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 4,
        buttonInsets: .horizontal(3, vertical: 4),
        rowHeight: 40)
    
    /**
     The standard config for an iPhone in portrait.
     */
    static let standardPhonePortrait = KeyboardLayoutConfiguration(
        buttonCornerRadius: 4,
        buttonInsets: .horizontal(3, vertical: 6),
        rowHeight: 54)
    
    /**
     The standard config for an iPhone Pro Max in landscape.
     */
    static let standardPhoneProMaxLandscape = KeyboardLayoutConfiguration
        .standardPhoneLandscape
    
    /**
     The standard config for an iPhone Pro Max in portrait.
     */
    static let standardPhoneProMaxPortrait = KeyboardLayoutConfiguration(
        buttonCornerRadius: 4,
        buttonInsets: .horizontal(3, vertical: 6),
        rowHeight: 56)
}

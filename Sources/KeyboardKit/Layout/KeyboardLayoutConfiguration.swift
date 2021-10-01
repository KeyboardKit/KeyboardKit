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
public struct KeyboardLayoutConfiguration {
    
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
        rowHeight: CGFloat) {
        self.buttonCornerRadius = buttonCornerRadius
        self.buttonInsets = buttonInsets
        self.rowHeight = rowHeight
    }
    
    /**
     The corner radius of a keyboard button in the keyboard.
     */
    public let buttonCornerRadius: CGFloat
    
    /**
     The edge insets of a keyboard button in the keyboard.
     */
    public let buttonInsets: EdgeInsets
    
    /**
     The total height incl. insets, of a row in the keyboard.
     */
    public let rowHeight: CGFloat
}

public extension KeyboardLayoutConfiguration {
    
    /**
     The standard configuration for an iPad in landscape.
     */
    static let standardForPadLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 6,
        buttonInsets: .horizontal(7, vertical: 6),
        rowHeight: 86)
    
    /**
     The standard configuration for an iPad in portait.
     */
    static let standardForPadPortrait = KeyboardLayoutConfiguration(
        buttonCornerRadius: 6,
        buttonInsets: .horizontal(6, vertical: 6),
        rowHeight: 67)
    
    /**
     The standard configuration for an iPhone in landscape.
     */
    static let standardForPhoneLandscape = KeyboardLayoutConfiguration(
        buttonCornerRadius: 4,
        buttonInsets: .horizontal(3, vertical: 4),
        rowHeight: 40)
    
    /**
     The standard configuration for an iPhone in portrait.
     */
    static let standardForPhonePortrait = KeyboardLayoutConfiguration(
        buttonCornerRadius: 4,
        buttonInsets: .horizontal(3, vertical: 6),
        rowHeight: 54)
    
    /**
     The standard configuration for the provided `context`.
     */
    static func standard(
        for context: KeyboardContext) -> KeyboardLayoutConfiguration {
        standard(
            for: context.device.userInterfaceIdiom,
            in: context.screenOrientation,
            withScreenSize: context.screen.bounds.size)
    }
    
    /**
     The standard configuration for the provided parameters.
     */
    static func standard(
        for idiom: UIUserInterfaceIdiom,
        in orientation: UIInterfaceOrientation,
        withScreenSize size: CGSize) -> KeyboardLayoutConfiguration {
        switch idiom {
        case .pad: return orientation.isLandscape ?
            standardForPadLandscape :
            standardForPadPortrait
        default: return orientation.isLandscape ?
            standardForPhoneLandscape :
            standardForPhonePortrait
        }
    }
}

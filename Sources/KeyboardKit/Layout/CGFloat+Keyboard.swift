//
//  CGFloat+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import UIKit

public extension CGFloat {
    
    
    // MARK: - Corner Radius
    
    static let standardKeyboardButtonCornerRadiusForPadLandscape: CGFloat = 4
    static let standardKeyboardButtonCornerRadiusForPadPortrait: CGFloat = 4
    static let standardKeyboardButtonCornerRadiusForPhoneLandscape: CGFloat = 4
    static let standardKeyboardButtonCornerRadiusForPhonePortrait: CGFloat = 4
    
    /**
     The standard corner radius of a system keyboard button,
     given a certain `context`.
     */
    static func standardKeyboardButtonCornerRadius(
        for context: KeyboardContext) -> CGFloat {
        standardKeyboardButtonCornerRadius(
            for: context.device.userInterfaceIdiom,
            in: context.screenOrientation,
            withScreenSize: context.screen.bounds.size)
    }
    
    /**
     The standard corner radius of a system keyboard button,
     given a certain `idiom` and `orientation`.
     */
    static func standardKeyboardButtonCornerRadius(
        for idiom: UIUserInterfaceIdiom,
        in orientation: UIInterfaceOrientation,
        withScreenSize size: CGSize) -> CGFloat {
        switch idiom {
        case .pad: return orientation.isLandscape ?
            standardKeyboardButtonCornerRadiusForPadLandscape :
            standardKeyboardButtonCornerRadiusForPadPortrait
        default: return orientation.isLandscape ?
            standardKeyboardButtonCornerRadiusForPhoneLandscape :
            standardKeyboardButtonCornerRadiusForPhonePortrait
        }
    }
    
    
    // MARK: - Row height
    
    static let standardKeyboardRowHeightForPadLandscape: CGFloat = 86
    static let standardKeyboardRowHeightForPadPortrait: CGFloat = 67
    static let standardKeyboardRowHeightForPhoneLandscape: CGFloat = 40
    static let standardKeyboardRowHeightForPhonePortrait: CGFloat = 54
    
    /**
     The standard, total height, including insets, for a row
     in a keyboard, given a certain `context`.
     */
    static func standardKeyboardRowHeight(
        for context: KeyboardContext) -> CGFloat {
        standardKeyboardRowHeight(
            for: context.device.userInterfaceIdiom,
            in: context.screenOrientation,
            withScreenSize: context.screen.nativeBounds.size)
    }
    
    /**
     The standard, total height, including insets, for a row
     in a keyboard, given a certain `idiom` and `orientation`.
     */
    static func standardKeyboardRowHeight(
        for idiom: UIUserInterfaceIdiom,
        in orientation: UIInterfaceOrientation,
        withScreenSize size: CGSize) -> CGFloat {
        switch idiom {
        case .pad: return orientation.isLandscape ?
            standardKeyboardRowHeightForPadLandscape :
            standardKeyboardRowHeightForPadPortrait
        default: return orientation.isLandscape ?
            standardKeyboardRowHeightForPhoneLandscape :
            standardKeyboardRowHeightForPhonePortrait
        }
    }
}

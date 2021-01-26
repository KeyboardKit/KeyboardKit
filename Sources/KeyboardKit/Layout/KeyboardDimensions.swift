//
//  KeyboardDimensions.swift
//  KeyboardKit
//
//  Created by Brennan Drew on 2021-01-19.
//

import CoreGraphics
import Combine
import SwiftUI

/**
 This struct specifies dimensions for a keyboard.
 */
public protocol KeyboardDimensions {
    
    var buttonHeight: CGFloat { get }
    var buttonInsets: EdgeInsets { get }
    var longButtonWidth: CGFloat { get }
    var shortButtonWidth: CGFloat { get }
    
    func width(for action: KeyboardAction, keyboardWidth: CGFloat, context: KeyboardContext) -> CGFloat?
}

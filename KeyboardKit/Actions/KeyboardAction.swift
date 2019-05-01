//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This enum contains all currently supported keyboard actions.
 
 */

import UIKit

public enum KeyboardAction: Equatable {
    
    case
    none,
    backspace,
    character(String),
    image(description: String, keyboardImageName: String, imageName: String),
    moveCursorBack,
    moveCursorForward,
    newLine,
    shift,
    space,
    switchKeyboard
}

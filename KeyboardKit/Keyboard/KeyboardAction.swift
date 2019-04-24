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
    nextKeyboard,
    shift,
    space
}


// MARK: - Public Functions

public extension KeyboardAction {
    
    var image: UIImage? {
        guard let name = imageName else { return nil }
        return UIImage(named: name)
    }
    
    var imageName: String? {
        switch self {
        case .image(_, _, let imageName): return imageName
        default: return nil
        }
    }
    
    var keyboardImage: UIImage? {
        guard let name = keyboardImageName else { return nil }
        return UIImage(named: name)
    }
    
    var keyboardImageName: String? {
        switch self {
        case .image(_, let keyboardImageName, _): return keyboardImageName
        default: return nil
        }
    }
    
    var shouldRepeatOnLongPress: Bool {
        switch self {
        case .backspace,
             .character,
             .moveCursorBack,
             .moveCursorForward,
             .newLine,
             .space: return true
        default: return false
        }
    }
    
    var title: String? {
        switch self {
        case .character(let character): return character
        default: return nil
        }
    }
}

//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This enum represents all keyboard actions, that KeyboardKit
 currently supports.
 
 */

import UIKit

public enum KeyboardAction {
    
    case
    none,
    backspace,
    character(String),
    image(description: String, keyboardImageName: String, imageName: String),
    newLine,
    nextKeyboard,
    shift,
    space
}


// MARK: - Public Functions

public extension KeyboardAction {
    
    public var image: UIImage? {
        guard let name = imageName else { return nil }
        return UIImage(named: name)
    }
    
    public var imageName: String? {
        switch self {
        case .image(_, _, let imageName): return imageName
        default: return nil
        }
    }
    
    public var isNextKeyboard: Bool {
        switch self {
        case .nextKeyboard: return true
        default: return false
        }
    }
    
    public var isNone: Bool {
        switch self {
        case .none: return true
        default: return false
        }
    }
    
    public var keyboardImage: UIImage? {
        guard let name = keyboardImageName else { return nil }
        return UIImage(named: name)
    }
    
    public var keyboardImageName: String? {
        switch self {
        case .image(_, let keyboardImageName, _): return keyboardImageName
        default: return nil
        }
    }
    
    public var title: String? {
        switch self {
        case .character(let character): return character
        default: return nil
        }
    }
}

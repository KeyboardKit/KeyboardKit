//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-25.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardButton: UIButton {
    
    open class func newWithCharacter(_ character: String) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = .character
        button.character = character
        button.setTitle(character, for: UIControlState())
        return button
    }
    
    open class func newWithEmoji(_ emojiName: String, imageName: String) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = .emoji
        button.emojiName = emojiName
        UIImage.asyncImageNamed(imageName) { image in
            button.keyboardImage = image
        }
        return button
    }
    
    open class func newWithOperation(_ operation: KeyboardOperation, title: String) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = operation
        button.setTitle(title, for: UIControlState())
        return button
    }
    
    open class func newWithOperation(_ operation: KeyboardOperation, image: UIImage) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = operation
        button.keyboardImage = image
        return button
    }

    
    
    open var character: String?
    
    open var emojiName: String?
    
    open var keyboardImage: UIImage? {
        get { return image(for: UIControlState()) }
        set { setImage(newValue, for: UIControlState()) }
    }
    
    open var operation: KeyboardOperation?
}

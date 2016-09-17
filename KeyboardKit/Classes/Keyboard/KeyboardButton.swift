//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-25.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardButton: UIButton {
    
    open class func new(withCharacter character: String) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = .character
        button.character = character
        button.setTitle(character, for: .normal)
        return button
    }
    
    open class func new(withEmoji emojiName: String, imageName: String) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = .emoji
        button.emojiName = emojiName
        button.keyboardImage = UIImage(named: imageName)
        return button
    }
    
    open class func new(withOperation operation: KeyboardOperation, title: String) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = operation
        button.setTitle(title, for: .normal)
        return button
    }
    
    open class func new(withOperation operation: KeyboardOperation, image: UIImage) -> KeyboardButton {
        let button = KeyboardButton(type: .custom)
        button.operation = operation
        button.keyboardImage = image
        return button
    }

    
    
    open var character: String?
    
    open var emojiName: String?
    
    open var keyboardImage: UIImage? {
        get { return image(for: .normal) }
        set { setImage(newValue, for: .normal) }
    }
    
    open var operation: KeyboardOperation?
}

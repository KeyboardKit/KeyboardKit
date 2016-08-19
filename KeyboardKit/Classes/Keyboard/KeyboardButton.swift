//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-25.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

import UIKit

public class KeyboardButton: UIButton {
    
    public class func newWithCharacter(character: String) -> KeyboardButton {
        let button = KeyboardButton(type: .Custom)
        button.operation = .Character
        button.character = character
        button.setTitle(character, forState: .Normal)
        return button
    }
    
    public class func newWithEmoji(emojiName: String, imageName: String) -> KeyboardButton {
        let button = KeyboardButton(type: .Custom)
        button.operation = .Emoji
        button.emojiName = emojiName
        UIImage.asyncImageNamed(imageName) { image in
            button.keyboardImage = image
        }
        return button
    }
    
    public class func newWithOperation(operation: KeyboardOperation, title: String) -> KeyboardButton {
        let button = KeyboardButton(type: .Custom)
        button.operation = operation
        button.setTitle(title, forState: .Normal)
        return button
    }
    
    public class func newWithOperation(operation: KeyboardOperation, image: UIImage) -> KeyboardButton {
        let button = KeyboardButton(type: .Custom)
        button.operation = operation
        button.keyboardImage = image
        return button
    }

    
    
    public var character: String?
    
    public var emojiName: String?
    
    public var keyboardImage: UIImage? {
        get { return imageForState(.Normal) }
        set { setImage(newValue, forState: .Normal) }
    }
    
    public var operation: KeyboardOperation?
}
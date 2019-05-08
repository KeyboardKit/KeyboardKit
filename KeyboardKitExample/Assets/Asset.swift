//
//  Asset.swift
//  KeyboardKitExample
//
//  Created by Daniel Saidi on 2018-03-26.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public enum Asset: String {
    
    case
    backspace,
    newLine,
    space,
    switchKeyboard
}

public extension Asset {
    
    var image: UIImage? {
        return UIImage(named: "\(rawValue)")
    }
}

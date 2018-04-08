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
    globe,
    newline,
    space
}

public extension Asset {
    
    public var image: UIImage? {
        return UIImage(named: "\(rawValue)")
    }
}

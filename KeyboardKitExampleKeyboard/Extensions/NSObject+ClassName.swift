//
//  NSObject+ClassName.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-11-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This extension returns the class name of any type. I use it
 to register and dequeue cells in the demo application.
 
 */

import Foundation

public extension NSObject {
    
    public static var className: String {
        return String(describing: self)
    }
}

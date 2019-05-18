//
//  KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-18.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This enum contains all keyboard types that can currently be
 bound to the `KeyboardAction` switch keyboard action.
 
 If you need a keyboard type that is not represented here or
 app-specific, you can use `.custom` with any name.
 
 */

import UIKit

public enum KeyboardType: Equatable {

    case
    alphabetic(uppercased: Bool),
    numeric,
    symbolic,
    email,
    emojis,
    custom(_ name: String)
}

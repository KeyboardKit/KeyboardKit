//
//  LocalizedKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public protocol LocalizedKeyboardInputSetProvider: KeyboardInputSetProvider{
    
    var localeKey: String { get }
}

//
//  KeyboardPresenter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 Keyboard presenters can be used to present keyboards in any
 kind of way, depending on which presenter you use.
 
 Make sure to call `refresh()` when the size of the keyboard
 extension change or whenever a layout change occurs.
 
 */

import Foundation

public protocol KeyboardPresenter {
    
    var id: String? { get }
    
    func refresh()
    func setup(with keyboard: Keyboard, in viewController: KeyboardInputViewController)
}

public class NoneKeyboardPresenter: KeyboardPresenter {
    
    public var id: String? { return "" }
    
    public func refresh() {}
    public func setup(with keyboard: Keyboard, in viewController: KeyboardInputViewController) {}
}

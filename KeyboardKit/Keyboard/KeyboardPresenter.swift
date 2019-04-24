//
//  KeyboardPresenter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 A keyboard presenter is anything that can present keyboards.
 The keyboard view controllers in the library are presenters.
 
 */

import Foundation

public protocol KeyboardPresenter {
    
    var id: String? { get }
}

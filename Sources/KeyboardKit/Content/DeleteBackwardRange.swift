//
//  DeleteBackwardRange.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This enum can be used to vary how the backspace action will
 behave when pressing and holding the backspace key.
 */
public enum DeleteBackwardRange {
    
    case char, word, sentence
}

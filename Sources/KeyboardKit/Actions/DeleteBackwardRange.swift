//
//  DeleteBackwardRange.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum can be used to vary how the backspace action will
 behave when pressing and holding the backspace key.
 */
public enum DeleteBackwardRange {

    /// Delete a single char at a time.
    case character

    /// Delete an entire word at a time.
    case word

    /// Delete an entire sentence at a time.
    case sentence
}

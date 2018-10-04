//
//  Int+Limit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Int {
    
    func limit(min: Int, max: Int) -> Int {
        if self < min { return min }
        if self > max { return max }
        return self
    }
}

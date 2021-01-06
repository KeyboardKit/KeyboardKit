//
//  KeyboardAction+Grid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Array where Element == KeyboardAction {
    
    /**
     This evens out the array to fit a grid with a `gridSize`
     number of columns, or a `gridSize` page size, by adding
     enough `.none` actions to the end of the array.
     */
    func evened(for gridSize: Int) -> [KeyboardAction] {
        var actions = self
        while actions.count % gridSize > 0 {
            actions.append(.none)
        }
        return actions
    }
}

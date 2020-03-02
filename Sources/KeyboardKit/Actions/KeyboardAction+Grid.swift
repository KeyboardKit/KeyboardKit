//
//  KeyboardAction+Grid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//

import Foundation

public extension Array where Element == KeyboardAction {
    
    /**
     Even out the action list to have as many rows as evenly
     fits a grid with `size` columns.
     */
    func evened(for gridSize: Int) -> [KeyboardAction] {
        var actions = self
        while actions.count % gridSize > 0 {
            actions.append(.none)
        }
        return actions
    }
}

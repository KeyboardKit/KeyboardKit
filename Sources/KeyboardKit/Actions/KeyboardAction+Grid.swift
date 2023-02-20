//
//  KeyboardAction+Grid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Array where Element == KeyboardAction {
    
    /**
     Fill the array with enough `none` actions to evenly fit
     a grid with `gridSize` number of columns or page size.
     */
    func evened(for gridSize: Int) -> [KeyboardAction] {
        var actions = self
        while actions.count % gridSize > 0 {
            actions.append(.none)
        }
        return actions
    }
}

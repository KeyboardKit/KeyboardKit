//
//  KeyboardAction+Grid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Array where Element == KeyboardAction {
    
    /// Add enough actions to make the array fit a grid with
    /// a certain number of columns.
    func evened(for columns: Int) -> [KeyboardAction] {
        var actions = self
        while actions.count % columns > 0 {
            actions.append(.none)
        }
        return actions
    }
}

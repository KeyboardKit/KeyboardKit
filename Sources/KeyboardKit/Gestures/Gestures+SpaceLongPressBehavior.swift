//
//  Gestures+SpaceLongPressBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-02-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Gestures {
    
    /**
     This enum defines various space key long press actions.
     */
    enum SpaceLongPressBehavior: Codable {
        
        /// Long pressing space moves the input cursor.
        case moveInputCursor
        
        /// Long pressing space opens a locale context menu.
        case openLocaleContextMenu
    }
}

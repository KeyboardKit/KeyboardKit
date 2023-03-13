//
//  SpaceLongPressBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-02-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines various space key long press actions.
 */
public enum SpaceLongPressBehavior: Codable {

    /// Long pressing space starts moving the input cursor.
    ///
    /// This is the default behavior in native iOS keyboards.
    case moveInputCursor

    /// Long pressing space opens a locale context menu.
    ///
    /// Only use this when you think that really makes sense.
    /// Long pressing space to start moving the input cursor
    /// is the default and expected behavior.
    case openLocaleContextMenu
}

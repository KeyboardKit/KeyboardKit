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
    case moveInputCursor

    /// Long pressing space opens a locale context menu.
    case openLocaleContextMenu
}

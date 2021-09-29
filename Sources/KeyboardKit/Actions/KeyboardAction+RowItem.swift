//
//  KeyboardAction+RowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This extension makes `KeyboardAction` conform to `RowItem`.
 */
extension KeyboardAction: RowItem {

    public var rowId: KeyboardAction { self }
}

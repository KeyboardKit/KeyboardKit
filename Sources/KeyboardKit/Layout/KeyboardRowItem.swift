//
//  KeyboardRowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that represent an
 item in a kind of row, such as input sets, layout items etc.

 The reason for having this protocol is mainly to have a way
 to share functionality. It is implemented by ``InputSetItem``
 and ``KeyboardLayoutItem`` and provide collection extension
 functions in `KeyboardRowItem+Collection`.
 
 The reason to why not using `Identifiable` instead, is that
 the row ID may not be unique. The same item may appear many
 times in the same row.
 */
public protocol KeyboardRowItem {
    
    associatedtype ID: Equatable
    
    /**
     An ID that identifies the item in a row. Note that this
     is not necessarily unique.
     */
    var rowId: ID { get }
}

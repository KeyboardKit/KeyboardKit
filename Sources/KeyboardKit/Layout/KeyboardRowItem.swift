//
//  KeyboardRowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that is stored
 in "rows" that should be easily mutated.
 
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

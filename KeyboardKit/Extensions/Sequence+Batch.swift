//
//  Sequence+Batch.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-05-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This extension is used by KeyboardKit to split up arrays in
 batches of a certain max size.
 
 */

import Foundation

public extension Sequence {
    
    public func batch(size: Int) -> [[Iterator.Element]] {
        var result: [[Iterator.Element]] = []
        var batch: [Iterator.Element] = []
        
        for element in self {
            batch.append(element)
            if batch.count == size {
                result.append(batch)
                batch = []
            }
        }
        
        if !batch.isEmpty {
            result.append(batch)
        }
        
        return result
    }
}

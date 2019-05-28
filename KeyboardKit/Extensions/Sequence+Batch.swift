//
//  Sequence+Batch.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-05-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This extension splits up arrays in batches of a certain max
 batch size.
 
 */

import Foundation

public extension Sequence {
    
    func batched(withBatchSize size: Int) -> [[Iterator.Element]] {
        var result: [[Iterator.Element]] = []
        var batch: [Iterator.Element] = []
        
        forEach {
            batch.append($0)
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

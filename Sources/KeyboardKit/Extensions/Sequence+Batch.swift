//
//  Sequence+Batch.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-05-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Sequence {
    
    /**
     
     Splits up the sequence in batches of a certain max size.
     For instance, batching up ["a", "b", "c"] in batches of
     max size 2 will return [["a", "b"], ["c"]].
     
     */
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

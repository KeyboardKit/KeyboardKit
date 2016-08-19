//
//  Array_Batch.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-04.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public func batchArray<T>(array: Array<T>, withBatchSize size: Int) -> [Array<T>] {
    var result = [Array<T>]()
    
    var count = 0
    var totalCount = 0
    var bucket:Array<T>? = nil
    
    for item in array {
        if (bucket == nil) {
            bucket = Array<T>()
        }
        
        count += 1
        totalCount += 1
        bucket?.append(item)
        if (count < size && totalCount < array.count) {
            continue
        }
            
        result.append(bucket!)
        bucket = nil
        count = 0
    }
    
    return result
}
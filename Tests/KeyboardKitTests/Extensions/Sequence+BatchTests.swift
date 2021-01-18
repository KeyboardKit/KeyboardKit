//
//  Sequence+BatchTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-05-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import KeyboardKit

private class TestSequenceItem: NSObject {
    
    init(_ name: String) {
        self.name = name
        super.init()
    }
    
    let name: String
}

class Sequence_BatchTests: QuickSpec {
    
    override func spec() {
        
        describe("batching array") {
            
            it("creates single batch if batch size exceeds array size") {
                let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                let batch = array.batched(withBatchSize: 20)
                
                expect(batch.count).to(equal(1))
                expect(batch.first!).to(equal(array))
            }
            
            it("creates multiple batches if array size exceeds batch size") {
                let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                let batch = array.batched(withBatchSize: 3)
                
                expect(batch.count).to(equal(4))
                expect(batch[0]).to(equal([1, 2, 3]))
                expect(batch[1]).to(equal([4, 5, 6]))
                expect(batch[2]).to(equal([7, 8, 9]))
                expect(batch[3]).to(equal([10]))
            }
            
            it("preserves identability") {
                let item1 = TestSequenceItem("1")
                let item2 = TestSequenceItem("2")
                let item3 = TestSequenceItem("3")
                let item4 = TestSequenceItem("4")
                
                let array = [item1, item2, item3, item4]
                let batch = array.batched(withBatchSize: 2)
                
                expect(batch.count).to(equal(2))
                expect(batch.last!).to(equal([item3, item4]))
            }
        }
    }
}

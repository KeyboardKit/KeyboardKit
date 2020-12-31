//
//  MockCollectionViewLayout.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import MockingKit
import UIKit

class MockCollectionViewLayout: UICollectionViewFlowLayout, Mockable {
    
    lazy var invalidateLayoutRef = MockReference(invalidateLayout as () -> Void)
    
    var mock = Mock()
    
    override func invalidateLayout() {
        invoke(invalidateLayoutRef, args: ())
    }
}

//
//  MockCollectionViewLayout.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Mockery
import UIKit

class MockCollectionViewLayout: UICollectionViewFlowLayout {
    
    var recorder = Mock()
    
    override func invalidateLayout() {
        recorder.invoke(invalidateLayout, args: ())
    }
}

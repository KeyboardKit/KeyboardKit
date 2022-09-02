//
//  MockCollectionViewLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import UIKit

@available(*, deprecated, message: "This will be removed in KeyboardKit 7.")
class MockCollectionViewLayout: UICollectionViewFlowLayout, Mockable {
    
    lazy var invalidateLayoutRef = MockReference(invalidateLayout as () -> Void)
    
    var mock = Mock()
    
    override func invalidateLayout() {
        call(invalidateLayoutRef, args: ())
    }
}
#endif

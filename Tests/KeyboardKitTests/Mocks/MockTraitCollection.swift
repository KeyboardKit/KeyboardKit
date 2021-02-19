//
//  MockTraitCollection.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

class MockTraitCollection: UITraitCollection {
    
    var userInterfaceStyleValue: UIUserInterfaceStyle = .light
    
    override var userInterfaceStyle: UIUserInterfaceStyle { userInterfaceStyleValue }
}

//
//  MockDevice.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

class MockDevice: UIDevice {
    
    var userInterfaceIdiomValue = UIUserInterfaceIdiom.phone
    
    override var userInterfaceIdiom: UIUserInterfaceIdiom {
        userInterfaceIdiomValue
    }
}

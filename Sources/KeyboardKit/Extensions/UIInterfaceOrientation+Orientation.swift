//
//  UIInterfaceOrientation+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIInterfaceOrientation {

    var isLandscape: Bool {
        self == .landscapeLeft || self == .landscapeRight
    }
    
    var isPortrait: Bool {
        self == .portrait || self == .portraitUpsideDown
    }
}

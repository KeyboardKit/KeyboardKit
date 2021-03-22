//
//  UIInterfaceOrientation+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIInterfaceOrientation {
    
    init?(_ orientation: UIDeviceOrientation) {
        guard let orientation = orientation.interfaceOrientation else { return nil }
        self = orientation
    }
}

extension UIDeviceOrientation {
    
    var interfaceOrientation: UIInterfaceOrientation? {
        switch self {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        default: return nil
        }
    }
}

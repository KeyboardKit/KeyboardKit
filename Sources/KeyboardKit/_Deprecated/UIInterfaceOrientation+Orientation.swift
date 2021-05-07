//
//  UIInterfaceOrientation+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIInterfaceOrientation {

    @available(*, deprecated, message: "This initializer will be removed in 5.0")
    init?(_ orientation: UIDeviceOrientation) {
        guard let orientation = orientation.interfaceOrientation else { return nil }
        self = orientation
    }
}

extension UIDeviceOrientation {
    
    @available(*, deprecated, message: "This property will be removed in 5.0")
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

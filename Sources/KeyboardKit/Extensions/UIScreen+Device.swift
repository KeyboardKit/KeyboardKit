//
//  UIScreen+Device.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIScreen {
    
    var isIPadProLargeScreen: Bool { hasSize(.iPadProLargeScreenPortrait) }
    var isIPadProSmallScreen: Bool { hasSize(.iPadProSmallScreenPortrait) }
    var isIPadScreen: Bool { hasSize(.iPadScreenPortrait) }
    var isIPhoneProMaxScreen: Bool { hasSize(.iPhoneProMaxScreenPortrait) }
}

private extension UIScreen {
    
    func hasSize(_ size: CGSize) -> Bool {
        bounds.size == size || bounds.size == size.flipped()
    }
}

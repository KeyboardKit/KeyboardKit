//
//  UIScreen+Device.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIScreen {
    
    var isIpadProLargeScreen: Bool { hasSize(.iPadProLargeScreenPortrait) }
    var isIpadProSmallScreen: Bool { hasSize(.iPadProSmallScreenPortrait) }
    var isIpadScreen: Bool { hasSize(.iPadScreenPortrait) }
    var isIphoneProMaxScreen: Bool { hasSize(.iPhoneProMaxScreenPortrait) }
}

private extension UIScreen {
    
    func hasSize(_ size: CGSize) -> Bool {
        bounds.size == size || bounds.size == size.flipped()
    }
}

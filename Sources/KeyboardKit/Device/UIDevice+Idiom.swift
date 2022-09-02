//
//  UIDevice+Idiom.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

extension UIDevice {
    
    /**
     Whether or not the device is an iPhone.
     */
    var isPhone: Bool { userInterfaceIdiom == .phone }
}
#endif

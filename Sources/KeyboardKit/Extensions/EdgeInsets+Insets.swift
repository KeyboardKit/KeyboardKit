//
//  UIEdgeInsets+Insets.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import SwiftUI

public extension EdgeInsets {
    
    /**
     Create `EdgeInsets` from a `UIEdgeInsets` instance.
     */
    init(insets: UIEdgeInsets) {
        self.init(
            top: insets.top,
            leading: insets.left,
            bottom: insets.bottom,
            trailing: insets.right)
    }
}

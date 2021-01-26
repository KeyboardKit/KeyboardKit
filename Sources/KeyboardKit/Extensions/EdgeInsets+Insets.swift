//
//  UIEdgeInsets+Insets.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit
import SwiftUI

public extension EdgeInsets {
    
    init(insets: UIEdgeInsets) {
        self.init(
            top: insets.top,
            leading: insets.left,
            bottom: insets.bottom,
            trailing: insets.right)
    }
    
    static func insets(from insets: UIEdgeInsets) -> EdgeInsets {
        EdgeInsets(insets: insets)
    }
}

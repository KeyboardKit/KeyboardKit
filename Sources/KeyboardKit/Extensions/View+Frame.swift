//
//  View+Frame.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-08.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {
    
    func frame(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
}

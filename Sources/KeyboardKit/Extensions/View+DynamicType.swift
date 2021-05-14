//
//  View+DynamicType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-14.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    func disableDynamicType() -> some View {
        self.environment(\.sizeCategory, .medium)
    }
}

//
//  AutocompleteToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view replicates the standard autocomplete toolbar item
 separator that is used in native iOS keyboards.
 */
public struct AutocompleteToolbarSeparator: View {
    
    public var body: some View {
        AnyView(
            Color.secondary
                .opacity(0.5)
                .frame(width: 1)
                .padding(.vertical, 8)
        )
    }
}

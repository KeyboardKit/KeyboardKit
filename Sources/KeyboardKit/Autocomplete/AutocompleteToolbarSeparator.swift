//
//  AutocompleteToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view replicates the standard autocomplete toolbar item
 separator that is used in native iOS keyboards.
 */
public struct AutocompleteToolbarSeparator: View {
    
    /**
     Create an autocomplete toolbar item separator.
     
     - Parameters:
       - style: The style to apply to the separator line, by default ``AutocompleteToolbarSeparatorStyle/standard``.
     */
    public init(style: AutocompleteToolbarSeparatorStyle = .standard) {
        self.style = style
    }
    
    private let style: AutocompleteToolbarSeparatorStyle
    
    public var body: some View {
        style.color
            .frame(width: style.width)
            .frame(height: style.height)
    }
}

struct AutocompleteToolbarSeparator_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            AutocompleteToolbarSeparator(style: .standard)
            AutocompleteToolbarSeparator(style: .preview1)
            AutocompleteToolbarSeparator(style: .preview2)
        }.frame(height: 50)
    }
}

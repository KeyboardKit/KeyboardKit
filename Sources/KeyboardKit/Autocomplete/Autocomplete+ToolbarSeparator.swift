//
//  Autocomplete+ToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /**
     This view mimics native autocomplete toolbar separators.
     */
    struct ToolbarSeparator: View {
        
        /**
         Create an autocomplete toolbar item separator.
         
         - Parameters:
           - style: The style to apply, by default `.standard`.
         */
        public init(
            style: KeyboardStyle.AutocompleteToolbarSeparator = .standard
        ) {
            self.style = style
        }
        
        private let style: KeyboardStyle.AutocompleteToolbarSeparator
        
        public var body: some View {
            style.color
                .frame(width: style.width)
                .frame(height: style.height)
        }
    }
}

struct Autocomplete_ToolbarSeparator_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            Autocomplete.ToolbarSeparator(style: .standard)
            Autocomplete.ToolbarSeparator(style: .preview1)
            Autocomplete.ToolbarSeparator(style: .preview2)
        }.frame(height: 50)
    }
}

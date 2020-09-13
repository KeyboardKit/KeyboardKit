//
//  AutocompleteToolbar.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKitSwiftUI
import SwiftUI

struct AutocompleteToolbar: View {
    
    @EnvironmentObject var context: ObservableAutocompleteContext
    
    var body: some View {
        HStack {
            ForEach(context.suggestions, id: \.self) {
                Text($0)
            }
        }.frame(height: 45)
    }
}

struct AutocompleteToolbar_Previews: PreviewProvider {
    static var previews: some View {
        AutocompleteToolbar()
    }
}

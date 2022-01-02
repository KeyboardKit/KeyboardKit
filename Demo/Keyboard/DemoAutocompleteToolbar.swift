//
//  DemoAutocompleteToolbar.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-09-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific toolbar always applies a height to avoid
 that the keyboard resizes when it gets suggestions and when
 it's empty.
 */
struct DemoAutocompleteToolbar: View {
    
    @EnvironmentObject private var context: AutocompleteContext
    @EnvironmentObject private var keyboardContext: KeyboardContext
    
    var body: some View {
        AutocompleteToolbar(
            suggestions: context.suggestions,
            locale: keyboardContext.locale)
            .frame(height: UIDevice.current.isPad ? 70 : 50)
    }
}

private extension UIDevice {
    
    var isPad: Bool { userInterfaceIdiom == .pad }
}

struct DemoAutocompleteToolbar_Previews: PreviewProvider {
    
    static var previews: some View {
        DemoAutocompleteToolbar()
    }
}

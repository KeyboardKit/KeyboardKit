//
//  DemoKeyboardView.swift
//  KeyboardUnicode
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This view sets up a `SystemKeyboard` as a keyboard view and
 adds an `AutocompleteToolbar` above it.

 This view automatically hides the autocomplete toolbar when
 the keyboard doesn't prefer autocomplete, but the height is
 still allocated, since it's needed by the keyboard callouts.
 */
struct DemoKeyboardView: View {

    unowned var controller: KeyboardInputViewController

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        SystemKeyboard(controller: controller)
    }
}

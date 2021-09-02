//
//  SystemKeyboardButtonBody.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view represents the body of a standard system keyboard
 button, which is the standard button type in iOS keyboards.
 
 This view will apply a `backgroundColor` and a `shadowColor`
 with a `shadowSize` height, that is added below it. It then
 applies a corner radius and adds the provided content above
 everything.
 */
struct SystemKeyboardButtonBody: View {
    
    let style: SystemKeyboardButtonBodyStyle
    
    var body: some View {
        style.buttonColor
            .cornerRadius(style.cornerRadius)
            .overlay(SystemKeyboardButtonShadow(style: style))
    }
}

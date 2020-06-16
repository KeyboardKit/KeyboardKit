//
//  KeyboardImageButtonPreview.swift
//  KeyboardKitSwiftUIPreviews
//
//  Created by Daniel Saidi on 2020-06-16.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKitSwiftUI
import SwiftUI

struct KeyboardImageButtonPreview: View {
    
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text(text).font(.title)
            KeyboardImageButton(
                image: .globe,
                tapAction: { self.text = "Tap" },
                longPressAction: { self.text = "Long Press!" }
            )
        }
    }
}

struct KeyboardImageButtonPreview_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardImageButtonPreview()
    }
}

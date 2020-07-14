//
//  KeyboardImageButtonPreview.swift
//  KeyboardKitSwiftUIPreviews
//
//  Created by Daniel Saidi on 2020-06-16.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import SwiftUI

struct KeyboardImageButtonPreview: View {
    
    @State private var text = ""
    @State private var color = Color.red
    @State private var counter = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text(text).font(.headline)
            Image.globe.handle(
                action: .command,
                with: StandardKeyboardActionHandler(inputViewController: KeyboardInputViewController()),
                text: $text
                
            )
        }
    }
}

extension View {
    
    func handle(action: KeyboardAction, with handler: KeyboardActionHandler, text: Binding<String>) -> some View {
        let tap = TapGesture().onEnded { _ in text.wrappedValue = "Tap!" }
        let doubleTap = TapGesture(count: 2).onEnded { _ in text.wrappedValue = "Double tap!" }
        let press = LongPressGesture(minimumDuration: 0.5).onEnded { _ in text.wrappedValue = "Long press!" }
        let repeating = DragGesture(minimumDistance: 0).onChanged { _ in text.wrappedValue = "Repeat!" }
        return self
            .gesture(tap.sequenced(before: doubleTap))
            .gesture(press.sequenced(before: repeating))
    }
}

struct KeyboardImageButtonPreview_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardImageButtonPreview()
    }
}

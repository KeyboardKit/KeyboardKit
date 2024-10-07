//
//  KeyboardView.swift
//  LeakTest
//
//  Created by Daniel Saidi on 2023-02-19.
//

import SwiftUI
import KeyboardKit

struct KeyboardView: View {

    let controller = KeyboardController()

    var body: some View {
        VStack {
            KeyboardView(
                controller: controller,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
            Text("Locale: \(controller.state.keyboardContext.locale.identifier)")
        }
        .padding()
    }
}

#Preview {
    KeyboardView()
}

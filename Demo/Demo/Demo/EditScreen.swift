//
//  EditScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct EditScreen: View {
    
    let appearance: UIKeyboardAppearance
    
    @State private var text = ""
    
    var body: some View {
        DemoList("Regular text field") {
            MultilineTextField(text: $text, appearance: appearance)
                .frame(height: 200)
            if appearance == .dark {
                Section(footer: footerText) {}
            }
        }
    }
}

private extension EditScreen {
    
    var footerText: some View {
        Text("Dark apperance keyboards are currently not correctly rendered. In light mode, they get dark mode colors. This is because the keyboard extension is given a dark mode, regardless of the system mode.")
            .multilineTextAlignment(.center)
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(appearance: .default)
    }
}

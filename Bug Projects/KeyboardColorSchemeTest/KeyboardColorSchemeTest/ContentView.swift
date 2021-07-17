//
//  ContentView.swift
//  KeyboardColorSchemeTest
//
//  Created by Daniel Saidi on 2021-07-17.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("This app and it's keyboard extension can be used to test color scheme and keyboard appearance. For now, editing a dark appearance text field makes the both dark for the extension. How can we find the system color scheme?")
            textField(title: "Light appearance", appearance: .default)
            textField(title: "Dark appearance", appearance: .dark)
            Spacer()
        }.padding()
    }
}

extension ContentView {
    
    func textField(title: String, appearance: UIKeyboardAppearance) -> some View {
        VStack(spacing: 0) {
            Text(title).font(.footnote)
            MultilineTextField(text: $text, appearance: appearance)
                .frame(height: 80)
                .border(Color.gray.opacity(0.3))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

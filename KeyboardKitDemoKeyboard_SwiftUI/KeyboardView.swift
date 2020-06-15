//
//  KeyboardView.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-06-10.
//

import SwiftUI
import KeyboardKit
import KeyboardKitSwiftUI

struct KeyboardView: View {
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        Text(text).onTapGesture {
            self.context.keyboardType = .email
        }
    }
}

private extension KeyboardView {
    
    var text: String {
        switch context.keyboardType {
        case .alphabetic: return "alpha"
        default: return "other"
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}

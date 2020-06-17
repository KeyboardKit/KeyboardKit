//
//  KeyboardView.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit
import KeyboardKitSwiftUI

struct KeyboardView: View {
    
    init(controller: KeyboardInputViewController) {
        self.controller = controller
    }
    
    private let controller: KeyboardInputViewController
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        Text(text)
            .handle(action: .backspace, with: controller.keyboardActionHandler)
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
        KeyboardView(controller: KeyboardInputViewController())
    }
}


extension View {
    
    func handle(action: KeyboardAction, with handler: KeyboardActionHandler) -> some View {
        let hasTap = handler.
        
        
        let tap = TapGesture().onEnded { _ in handler.handle(.tap, on: action) }
        let doubleTap = TapGesture(count: 2).onEnded { _ in handler.handle(.doubleTap, on: action) }
        let press = LongPressGesture(minimumDuration: 0.5).onEnded { _ in handler.handle(.longPress, on: action) }
        let repeating = DragGesture(minimumDistance: 0).onChanged { _ in handler.handle(.repeatPress, on: action) }
        return self
            .gesture(tap.sequenced(before: doubleTap))
            .gesture(press.sequenced(before: repeating))
    }
}

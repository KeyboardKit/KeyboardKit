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
        let hasTap = handler.canHandle(.tap, on: action, sender: nil)
        let hasDoubleTap = handler.canHandle(.doubleTap, on: action, sender: nil)
        let hasLongPress = handler.canHandle(.longPress, on: action, sender: nil)
        let hasRepeatPress = handler.canHandle(.repeatPress, on: action, sender: nil)
        
        let tap = hasTap ? TapGesture().onEnded { _ in handler.handle(.tap, on: action) } : nil
        let doubleTap = hasDoubleTap ? TapGesture(count: 2).onEnded { _ in handler.handle(.doubleTap, on: action) } : nil
        let longPress = hasLongPress ? LongPressGesture(minimumDuration: 0.5).onEnded { _ in handler.handle(.longPress, on: action) } : nil
        let repeatPress = hasRepeatPress ? DragGesture(minimumDistance: 0).onChanged { _ in handler.handle(.repeatPress, on: action) } : nil
            
        let gestures = [tap, doubleTap, longPress, repeatPress].compactMap { $0 }
        
        
        
        
        return self
            .gesture(tap.sequenced(before: doubleTap))
            .gesture(press.sequenced(before: repeating))
    }
}

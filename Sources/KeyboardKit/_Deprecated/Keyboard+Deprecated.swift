import SwiftUI

public extension Keyboard {
    
    @available(*, deprecated, renamed: "Services")
    typealias KeyboardServices = Services
    
    @available(*, deprecated, renamed: "State")
    typealias KeyboardState = State
}

public extension View {
    
    @available(*, deprecated, renamed: "keyboardState(_:)")
    func withEnvironment(fromState state: Keyboard.State) -> some View {
        self.keyboardState(state)
    }
}

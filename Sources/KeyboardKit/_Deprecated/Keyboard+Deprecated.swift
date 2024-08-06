import SwiftUI

public extension Keyboard {
    
    @available(*, deprecated, renamed: "Services")
    typealias KeyboardServices = Services
    
    @available(*, deprecated, renamed: "State")
    typealias KeyboardState = State
}

public extension KeyboardSettings {

    @available(*, deprecated, renamed: "Keyboard.SettingsLink")
    typealias Link = Keyboard.SettingsLink
}

public extension Keyboard.State {

    @available(*, deprecated, message: "Use the dictation context's keyboardConfiguration instead.")
    var dictationConfig: Dictation.KeyboardConfiguration {
        dictationContext.keyboardConfiguration
    }
}

public extension View {
    
    @available(*, deprecated, renamed: "keyboardState(_:)")
    func withEnvironment(fromState state: Keyboard.State) -> some View {
        self.keyboardState(state)
    }

    #if os(iOS) || os(tvOS) || os(visionOS)
    @available(*, deprecated, message: "Use the non-controller based modifier instead.")
    func keyboardState(
        from controller: KeyboardInputViewController
    ) -> some View {
        self.keyboardState(controller.state)
    }

    @available(*, deprecated, renamed: "keyboardState(from:)")
    func withEnvironment(
        fromController controller: KeyboardInputViewController
    ) -> some View {
        self.keyboardState(from: controller)
    }
    #endif
}

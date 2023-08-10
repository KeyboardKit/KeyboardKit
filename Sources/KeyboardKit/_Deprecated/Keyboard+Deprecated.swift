import Foundation

@available(*, deprecated, renamed: "Keyboard.AutocapitalizationType")
public typealias KeyboardAutocapitalizationType = Keyboard.AutocapitalizationType

@available(*, deprecated, renamed: "Keyboard.BackspaceRange")
public typealias KeyboardBackspaceRange = Keyboard.BackspaceRange

@available(*, deprecated, renamed: "Keyboard.Case")
public typealias KeyboardCase = Keyboard.Case

@available(*, deprecated, renamed: "Keyboard.ReturnKeyType")
public typealias KeyboardReturnKeyType = Keyboard.ReturnKeyType

@available(*, deprecated, renamed: "Keyboard.KeyboardType")
public typealias KeyboardType = Keyboard.KeyboardType

#if os(iOS) || os(tvOS)
@available(*, deprecated, renamed: "KeyboardEnabledContext")
public typealias KeyboardEnabledState = KeyboardEnabledContext
#endif

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public protocol KeyboardCaseAdjustable {

    /**
     Get the capitalized value.
     */
    func capitalized() -> String

    /**
     Get the currently cased value.
     */
    func current() -> String

    /**
     Get the lowercased value.
     */
    func lowercased() -> String

    /**
     Get the uppercased value.
     */
    func uppercased() -> String
}

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public extension KeyboardCaseAdjustable {

    /**
     Get a case-adjusted value that matches the `text`.

     This will match capitalization, uppercase and lowercase
     states in that order, meaning that a single, uppercased
     character is interpreted as capitalized, not uppercased.
     */
    func caseAdjusted(for text: String) -> String {
        if text.isCapitalized {
            return self.capitalized()
        }
        if text == text.uppercased() {
            return self.uppercased()
        }
        if text == text.lowercased() {
            return self.lowercased()
        }
        return self.current()
    }
}

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
extension String: KeyboardCaseAdjustable {

    public func capitalized() -> String {
        self.capitalized
    }

    public func current() -> String {
        self
    }
}

@available(*, deprecated, message: "This is no longer used.")
open class StaticKeyboardBehavior: KeyboardBehavior {

    /**
      Create a static keyboard behavior instance.

      - Parameters:
        - keyboardContext: The keyboard context to use.
     */
    public init(keyboardContext: KeyboardContext) {
        self.keyboardContext = keyboardContext
    }


    /// The keyboard context to use.
    private let keyboardContext: KeyboardContext
    
    
    /**
     The range that the backspace key should delete when the
     key is long pressed.
     */
    open var backspaceRange: Keyboard.BackspaceRange { .character }
    
    /**
     The preferred keyboard type that should be applied when
     a certain gesture has been performed on an action.
     */
    open func preferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardType {
        keyboardContext.keyboardType
    }
    
    /**
     Whether or not to end the currently typed sentence when
     a certain gesture has been performed on an action.
     */
    open func shouldEndSentence(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to capslock when a gesture has
     been performed on an action.
     */
    open func shouldSwitchToCapsLock(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     when a certain gesture has been performed on an action.
     */
    open func shouldSwitchToPreferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     after the text document proxy text did change.
     */
    open func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool {
        false
    }
}

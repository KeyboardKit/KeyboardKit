import SwiftUI

@available(*, deprecated, renamed: "Keyboard.StandardBehavior")
public typealias StandardKeyboardBehavior = Keyboard.StandardBehavior


@available(*, deprecated, renamed: "KeyboardAction.StandardHandler")
public typealias StandardKeyboardActionHandler = KeyboardAction.StandardHandler

public extension KeyboardAction.StandardHandler {

    @available(*, deprecated, message: "Use feedbackContext instead.")
    convenience init(
        controller: KeyboardController?,
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        autocompleteContext: AutocompleteContext,
        feedbackConfiguration: FeedbackConfiguration,
        spaceDragGestureHandler: Gestures.SpaceDragGestureHandler
    ) {
        self.init(
            controller: controller,
            keyboardContext: keyboardContext,
            keyboardBehavior: keyboardBehavior,
            autocompleteContext: autocompleteContext,
            feedbackContext: feedbackConfiguration,
            feedbackService: Feedback.StandardService(),
            spaceDragGestureHandler: spaceDragGestureHandler
        )
    }
}

public extension KeyboardStyle {
    
    @available(*, deprecated, renamed: "Keyboard.AppearanceViewModifier")
    typealias KeyboardAppearanceViewModifier = Keyboard.AppearanceViewModifier
}

@available(*, deprecated, message: "This will be removed in KeyboardKit 9")
public extension Keyboard.AppearanceViewModifier {
    
    @available(*, deprecated, renamed: "init(_:)")
    init(appearance: ColorScheme) {
        self.init(appearance)
    }
}


@available(*, deprecated, renamed: "Autocomplete.LocalService")
public typealias LocalAutocompleteProvider = Autocomplete.LocalService

@available(*, deprecated, renamed: "Autocomplete.RemoteService")
public typealias RemoteAutocompleteProvider = Autocomplete.RemoteService

public extension Autocomplete {

    @available(*, deprecated, renamed: "Autocomplete.LocalService")
    class LocalProvider {}

    @available(*, deprecated, renamed: "Autocomplete.RemoteService")
    class RemoteProvider {}
}


@available(*, deprecated, renamed: "Dictation.ProService")
public typealias ProDictationService = Dictation.ProService

@available(*, deprecated, renamed: "Dictation.ProKeyboardService")
public typealias ProKeyboardDictationService = Dictation.ProKeyboardService


@available(*, deprecated, renamed: "KeyboardLayout.BaseService")
public typealias BaseKeyboardLayoutProvider = KeyboardLayout.BaseService

@available(*, deprecated, renamed: "KeyboardLayout.DeviceBasedService")
public typealias InputSetBasedKeyboardLayoutProvider = KeyboardLayout.DeviceBasedService

@available(*, deprecated, renamed: "KeyboardLayout.iPadService")
public typealias iPadKeyboardLayoutProvider = KeyboardLayout.iPadService

@available(*, deprecated, renamed: "KeyboardLayout.iPadProService")
public typealias iPadProKeyboardLayoutProvider = KeyboardLayout.iPadProService

@available(*, deprecated, renamed: "KeyboardLayout.iPhoneService")
public typealias iPhoneKeyboardLayoutProvider = KeyboardLayout.iPhoneService

@available(*, deprecated, renamed: "KeyboardLayout.StandardService")
public typealias StandardKeyboardLayoutProvider = KeyboardLayout.StandardService

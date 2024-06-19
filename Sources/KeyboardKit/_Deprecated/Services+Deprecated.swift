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
            spaceDragGestureHandler: spaceDragGestureHandler
        )
    }
}

public extension KeyboardStyle {
    
    @available(*, deprecated, renamed: "Keyboard.AppearanceViewModifier")
    typealias KeyboardAppearanceViewModifier = Keyboard.AppearanceViewModifier
}

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


@available(*, deprecated, renamed: "Callouts.BaseActionProvider")
public typealias BaseCalloutActionProvider = Callouts.BaseActionProvider

@available(*, deprecated, renamed: "Callouts.StandardActionProvider")
public typealias StandardCalloutActionProvider = Callouts.StandardActionProvider


@available(*, deprecated, renamed: "Dictation.ProService")
public typealias ProDictationService = Dictation.ProService

@available(*, deprecated, renamed: "Dictation.ProKeyboardService")
public typealias ProKeyboardDictationService = Dictation.ProKeyboardService


@available(*, deprecated, renamed: "KeyboardLayout.BaseProvider")
public typealias BaseKeyboardLayoutProvider = KeyboardLayout.BaseProvider

@available(*, deprecated, renamed: "KeyboardLayout.DeviceBasedProvider")
public typealias InputSetBasedKeyboardLayoutProvider = KeyboardLayout.DeviceBasedProvider

@available(*, deprecated, renamed: "KeyboardLayout.iPadProvider")
public typealias iPadKeyboardLayoutProvider = KeyboardLayout.iPadProvider

@available(*, deprecated, renamed: "KeyboardLayout.iPadProProvider")
public typealias iPadProKeyboardLayoutProvider = KeyboardLayout.iPadProProvider

@available(*, deprecated, renamed: "KeyboardLayout.iPhoneProvider")
public typealias iPhoneKeyboardLayoutProvider = KeyboardLayout.iPhoneProvider

@available(*, deprecated, renamed: "KeyboardLayout.StandardProvider")
public typealias StandardKeyboardLayoutProvider = KeyboardLayout.StandardProvider


@available(*, deprecated, renamed: "KeyboardStyle.StandardProvider")
public typealias StandardKeyboardStyleProvider = KeyboardStyle.StandardProvider

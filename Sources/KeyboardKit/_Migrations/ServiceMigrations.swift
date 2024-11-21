import SwiftUI

public extension Keyboard {

    @available(*, deprecated, renamed: "StandardKeyboardBehavior", message: "Migration Deprecation, will be removed in 9.1!")
    typealias StandardBehavior = StandardKeyboardBehavior
}

public extension Autocomplete {

    @available(*, deprecated, renamed: "DisabledAutocompleteService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias DisabledService = DisabledAutocompleteService

    @available(*, deprecated, renamed: "LocalAutocompleteService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias LocalService = LocalAutocompleteService

    @available(*, deprecated, renamed: "RemoteAutocompleteService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias RemoteService = RemoteAutocompleteService
}

public extension Dictation {

    @available(*, deprecated, renamed: "DisabledDictationService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias DisabledService = DisabledDictationService

    @available(*, deprecated, renamed: "StandardDictationService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias StandardService = StandardDictationService
}

public extension KeyboardFeedback {

    @available(*, deprecated, renamed: "DisabledFeedbackService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias DisabledService = DisabledFeedbackService

    @available(*, deprecated, renamed: "StandardFeedbackService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias StandardService = StandardFeedbackService
}

public extension KeyboardAction {

    @available(*, deprecated, renamed: "StandardActionHandler", message: "Migration Deprecation, will be removed in 9.1!")
    typealias StandardHandler = StandardActionHandler
}

public extension KeyboardCallout {

    @available(*, deprecated, renamed: "BaseCalloutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias BaseService = BaseCalloutService

    @available(*, deprecated, renamed: "StandardCalloutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias StandardService = StandardCalloutService

    @available(*, deprecated, renamed: "ProCalloutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias ProService = ProCalloutService
}

public extension KeyboardLayout {

    @available(*, deprecated, renamed: "BaseLayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias BaseService = BaseLayoutService

    @available(*, deprecated, renamed: "DeviceBasedLayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias DeviceBasedService = DeviceBasedLayoutService

    @available(*, deprecated, renamed: "iPadLayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias iPadService = iPadLayoutService

    @available(*, deprecated, renamed: "iPhoneLayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias iPhoneService = iPhoneLayoutService

    @available(*, deprecated, renamed: "StandardLayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias StandardService = StandardLayoutService

    @available(*, deprecated, renamed: "ProLayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias ProService = ProLayoutService

    @available(*, deprecated, renamed: "iPadProLayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias iPadProService = iPadProLayoutService
}

public extension KeyboardStyle {

    @available(*, deprecated, renamed: "StandardStyleService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias StandardService = StandardStyleService

    @available(*, deprecated, renamed: "ThemeBasedStyleService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias ThemeBasedService = ThemeBasedStyleService
}

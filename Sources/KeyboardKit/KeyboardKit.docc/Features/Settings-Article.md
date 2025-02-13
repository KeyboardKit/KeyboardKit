# Settings

This article describes the KeyboardKit settings engine and its available settings.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit provides you with auto-persisted keyboard-related settings, as well as ways to integrate with System Settings. You can use this to provide users with ways to open System Settings from the app and keyboard, and to configure the keyboard extension.


## Settings Types

KeyboardKit has ``KeyboardSettings``, ``AutocompleteSettings``, ``DictationSettings``, ``KeyboardFeedbackSettings``, and ``KeyboardThemeSettings`` types that provide auto-persisted settings for the various namespaces.

KeyboardKit sets up settings instances in the various context, like the ``KeyboardContext`` ``KeyboardContext/settings-swift.property`` property, and use these as the main setting types. The various contexts can also use their settings to modify their own behavior.

The separation between contexts and settings, is with the intention that a context should provide runtime-specific information, while a settings type should provide auto-persisted properties that can be set by code or be bound to a settings form.


## Settings Observation

Note that while a context's settings property, like ``KeyboardContext/settings-swift.property`` is marked as `@Published`, it will not publish any changes made to values within the type, e.g. when using a form. This means that views will by default not update if another view makes a change to a property.

You can solve this by using local state properties, bind those properties to the view or form, initialize the properties with the settings you want to affect, and sync any state changes back to those settings. 



## Settings Persistency & Sync

The ``KeyboardSettings`` class has a ``KeyboardSettings/store`` that is used by all settings types to persist data. This store will automatically sync data between the main app and its keyboard if you use a ``KeyboardApp`` that defines an ``KeyboardApp/appGroupId`` to set up the app and keyboard.

> Important: The auto-peristed settings properties will use the store that is available when they're first used, so make sure to set up your app and keyboard as shown in <doc:Getting-Started-Article>, *before* accessing any of these properties.



## System Settings

Since keyboard extensions can only access a limited set of all System Settings, your app must provide its own settings to great extent. This is made easy with KeyboardKit's settings types and KeyboardKit Pro's settings screens (see <doc:App-Article>).

For settings that *must* be done on a system level, your app or keyboard can open System Settings by triggering the ``Foundation/URL/systemSettings`` URL. This can be used to let your users enable your keyboard, enable Full Access, etc. 

You can use a SwiftUI Link to open the URL, or trigger ``KeyboardActionHandler/handle(action:)`` with a ``KeyboardAction/url(_:id:)`` in any ``KeyboardActionHandler``.

```swift
if let url = URL.systemSettings {
    Link("Open System Settings", destination: url)
}
```

If your app or keyboard randomly navigates to the Settings root instead of your app, try adding an empty Settings Bundle to your app.



## Available Settings

KeyboardKit currently provides the following settings, some of which are derived from other values:


### Keyboard

``KeyboardSettings`` has the following settings:

* ``KeyboardSettings/addedLocales`` - A list of activated or user-selected locales.
* ``KeyboardSettings/inputToolbarType-swift.property`` - The input toolbar type to use.
* ``KeyboardSettings/isAutocapitalizationEnabled`` - Whether auto-capitalization is enabled.
* ``KeyboardSettings/isKeyboardAutoCollapseEnabled`` - Whether to auto-collapse the keyboard when an external keyboard is connected.
* ``KeyboardSettings/keyboardDockEdge`` - The keyboard dock edge to use, if any.
* ``KeyboardSettings/keyboardLayoutTypeIdentifier`` - The current layout type identifier, set by ``KeyboardContext/keyboardLayoutType``.
* ``KeyboardSettings/localeIdentifier`` - The current locale identifier, set by ``KeyboardContext/locale``. 
* ``KeyboardSettings/spaceLongPressBehavior`` - The long press behavior to use for the space key.
* ``KeyboardSettings/spaceTrailingAction`` - An optional trailing action to add to the space key, if any.

Most of the keyboard settings can also be managed from the ``KeyboardApp/SettingsScreen``, and the locale settings from the ``KeyboardApp/LocaleScreen``.

### Autocomplete

``AutocompleteSettings`` has the following settings:

* ``AutocompleteSettings/isAutocompleteEnabled`` - Whether autocomplete is enabled. 
* ``AutocompleteSettings/isAutocorrectEnabled`` - Whether autocorrect is enabled. 
* ``AutocompleteSettings/isAutolearnEnabled`` - Whether to autolearn unknown suggestions. 
* ``AutocompleteSettings/isAutoIgnoreEnabled`` - Whether to automatically ignore adjusted suggestions. 
* ``AutocompleteSettings/isNextCharacterPredictionEnabled`` - Whether next character prediction is enabled. 
* ``AutocompleteSettings/isNextWordPredictionEnabled`` - Whether next word prediction is enabled. 
* ``AutocompleteSettings/nextWordPredictionRequestApiKey`` - A custom, user-specified next word predicton request API key. 
* ``AutocompleteSettings/nextWordPredictionRequestType`` - A custom, user-specified next word predicton request type. 
* ``AutocompleteSettings/suggestionsDisplayCount`` - The number of autocomplete suggestions to display.

Most of these settings can also be managed from the ``KeyboardApp/SettingsScreen``.

### Dictation

``DictationSettings`` has the following settings:

* ``DictationSettings/silenceLimit`` - The max number of seconds of silence after which dictation ends.

This setting can also be managed from the ``KeyboardApp/SettingsScreen``.

### Feedback

``KeyboardFeedbackSettings`` has the following settings:

* ``KeyboardFeedbackSettings/isAudioFeedbackEnabled`` - Whether audio feedback is enabled.
* ``KeyboardFeedbackSettings/isHapticFeedbackEnabled`` - Whether Haptic feedback is enabled.

These settings can also be managed from the ``KeyboardApp/SettingsScreen``.

### Themes

``KeyboardThemeSettings`` has the following settings:

* ``KeyboardThemeSettings/theme`` - The currently selected theme, if any.

This setting can also be managed from the ``KeyboardApp/ThemeScreen``.

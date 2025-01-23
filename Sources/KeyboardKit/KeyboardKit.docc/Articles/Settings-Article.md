# Settings

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

This article describes the KeyboardKit settings engine and its available settings.

KeyboardKit provides you with auto-persisted keyboard-related settings, as well as ways to integrate with System Settings. You can use this to provide users with ways to open System Settings from the app and keyboard, and to configure the keyboard extension.



## Keyboard Settings

KeyboardKit has a ``Keyboard/Settings`` class that has a global ``Keyboard/Settings/store`` for persisting settings. It will automatically sync settings between the main app and its keyboard if you use a ``KeyboardApp`` that defines an App Group. Read more in the "How to..." section.

Since auto-peristed settings properties use `@AppStorage`, they will use the store available when they're first used. You must therefore set up your custom store before accessing any of these properties.

Each namespace has a separate settings class that provides namespace-related settings. Each context has a ``KeyboardContext/settings-swift.property`` property that acts as the main settings instance for each namespace.


## Contexts vs. Settings

The separation between the context and the setting types, is with the intention that the context types should provide runtime-specific information, while the settings types should provide auto-persisted configuration properties.

In other words, a context type should provide observable, observable state, while a settings type should provide persisted properties. Any property that is added to a settings type should be OK to expose to the user as a setting.

Since the settings concept is fairly new, there are several context properties that should rather be settings. This will be implemented over time. Reach out if you would like to use a context value as a setting instead.


## Available Settings

KeyboardKit currently provides the following settings for the various namespaces:


### Keyboard

The ``Keyboard``.``Keyboard/Settings`` class provides the following settings, as well as other settings-related properties and functions.

* ``Keyboard/Settings/addedLocales`` - A list of activated or user-selected locales.
* ``Keyboard/Settings/isAutocapitalizationEnabled`` - Whether auto-capitalization is enabled.
* ``Keyboard/Settings/isKeyboardAutoCollapseEnabled`` - Whether to auto-collapse the keyboard when users connect an external keyboard.
* ``Keyboard/Settings/keyboardDockEdge`` - An optional edge to which the keyboard is docked.
* ``Keyboard/Settings/localeIdentifier`` - The identifier of the current locale, set with the ``KeyboardContext/locale``. 

### Autocomplete

The ``Autocomplete``.``Autocomplete/Settings`` class provides the following settings, as well as other settings-related properties and functions.

* ``Autocomplete/Settings/isAutocompleteEnabled`` - Whether autocomplete is enabled. 
* ``Autocomplete/Settings/isAutocorrectEnabled`` - Whether autocorrect is enabled. 
* ``Autocomplete/Settings/isAutolearnEnabled`` - Whether to autolearn unknown suggestions. 
* ``Autocomplete/Settings/isAutoIgnoreEnabled`` - Whether to automatically ignore adjusted suggestions. 
* ``Autocomplete/Settings/isNextCharacterPredictionEnabled`` - Whether next character prediction is enabled. 
* ``Autocomplete/Settings/isNextWordPredictionEnabled`` - Whether next word prediction is enabled. 
* ``Autocomplete/Settings/nextWordPredictionRequestApiKey`` - A custom, user-specified next word predicton request API key. 
* ``Autocomplete/Settings/nextWordPredictionRequestType`` - A custom, user-specified next word predicton request type. 
* ``Autocomplete/Settings/suggestionsDisplayCount`` - The number of autocomplete suggestions to display.

### Dictation

The ``Dictation``.``Dictation/Settings`` class provides the following settings, as well as other settings-related properties and functions.

* ``Dictation/Settings/silenceLimit`` - The max number of seconds of silence after which dictation ends.

### Feedback

The ``KeyboardFeedback``.``KeyboardFeedback/Settings`` class provides the following settings, as well as other settings-related properties and functions.

* ``KeyboardFeedback/Settings/isAudioFeedbackEnabled`` - Whether audio feedback is enabled.
* ``KeyboardFeedback/Settings/isHapticFeedbackEnabled`` - Whether Haptic feedback is enabled. 


---


## How to...


### ...sync data between an app and its keyboard

To sync data between an app and its keyboard, you must create an App Group and link it to both the app and its keyboard. You can then add the App Group ID to your ``KeyboardApp`` to automatically set up your app and keyboard, as described in <doc:App-Article>.

You can also use ``Keyboard/Settings/setupStore(forAppGroup:keyPrefix:)`` to set up a store for an App Group, without using a ``KeyboardApp``.

> Important: The main app will always write data to an App Group in a way that is instantly available to the keyboard. A keyboard must however have Full Access enabled for changes to immediately sync with the app. When Full Access is disabled, syncing is less reliable.



### ...open System Settings

KeyboardKit defines a ``Foundation/URL/systemSettings`` URL that can be used to open your app's settings screen in System Settings, where users can enable your keyboard, enable Full Access, etc. 

You can use a SwiftUI link to open it from both your app and its keyboard, or trigger ``KeyboardActionHandler/handle(action:)`` with a ``KeyboardAction/url(_:id:)`` action.

```swift
if let url = URL.systemSettings {
    Link("Open System Settings", destination: url)
}
```

> Note: If your app randomly navigates to the Settings root instead of your app, try adding an empty settings bundle to your app.



## ...integrate with System Settings

A common feature request is to be able to access various settings from System Settings, for instance autocapitalization & autocorrect preferences that the user has configured.

This is not possible, at least not with the public APIs. This is most probably due to privacy concerns, and unfortunately means that your app must provide its own keyboard settings.

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

KeyboardKit has ``KeyboardSettings`` and other namespace-specific settings types that provide the following auto-persisted settings:

@TabNavigator {
    
    @Tab("Keyboard") {
        ``KeyboardSettings/addedLocales``
        
        ``KeyboardSettings/inputToolbarType-swift.property``
        
        ``KeyboardSettings/isAutocapitalizationEnabled``
        
        ``KeyboardSettings/isKeyboardAutoCollapseEnabled``
        
        ``KeyboardSettings/keyboardDockEdge``
        
        ``KeyboardSettings/keyboardLayoutTypeIdentifier``
        
        ``KeyboardSettings/localeIdentifier``
        
        ``KeyboardSettings/spaceContextMenuLeading``
        
        ``KeyboardSettings/spaceContextMenuTrailing``
        
        ``KeyboardSettings/spaceLongPressBehavior``
    }
    
    @Tab("Autocomplete") {
        ``AutocompleteSettings/isAutocompleteEnabled``
        
        ``AutocompleteSettings/isAutocorrectEnabled``
        
        ``AutocompleteSettings/isAutolearnEnabled``
        
        ``AutocompleteSettings/isAutoIgnoreEnabled``
        
        ``AutocompleteSettings/isEmojiAutocompleteEnabled``
        
        ``AutocompleteSettings/isNextCharacterPredictionEnabled``
        
        ``AutocompleteSettings/isNextWordPredictionEnabled``
        
        ``AutocompleteSettings/nextWordPredictionRequestApiKey``
        
        ``AutocompleteSettings/nextWordPredictionRequestType``
        
        ``AutocompleteSettings/suggestionsDisplayCount``
    }
    
    @Tab("Dictation") {
        ``DictationSettings/silenceLimit``
    }
    
    @Tab("Feedback") {
        ``KeyboardFeedbackSettings/isAudioFeedbackEnabled``
        
        ``KeyboardFeedbackSettings/isHapticFeedbackEnabled``
    }
    
    @Tab("Themes") {
        ``KeyboardThemeSettings/theme``
    }
}

These settings can be set with code or presented to the user, for instance using the various KeyboardKit Pro settings screens. See the <doc:App-Article> article for more information.    

The various context classes have settings properties, like ``KeyboardContext`` ``KeyboardContext/settings-swift.property``, that are used as the main settings values. The distinction between contexts and settings, is that a context provides contextual information, while settings provide persisted ones.


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

# Essentials

This article describes the essential parts of KeyboardKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

KeyboardKit extends Apple's native APIs and provides you with a lot more functionality. It lets you mimic the native iOS keyboard and tweak its style and behavior, or create completely custom keyboards.

KeyboardKit also has a ``KeyboardView`` view that mimics the native iOS keyboard. It can be customized and styled to great extent, and be customized with any views you like.

👑 [KeyboardKit Pro][Pro] unlocks a lot of essential Pro features. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespaces

KeyboardKit uses namespaces to make the API surface smaller, by nesting types in logical groups. 

KeyboardKit has other namespaces as well, for more specific capabilities, like ``KeyboardAction``, ``KeyboardLayout``, ``Callouts``, ``Dictation``, ``Feedback``, etc.

Namespaces will not contain protocols, nor important types that are meant to be exposed as top-level types. This includes essential types like ``KeyboardInputViewController``, context and settings types like ``KeyboardContext`` and ``KeyboardSettings``, and important components like ``KeyboardView``.



## Keyboard Namespace

The ``Keyboard`` namespace contains a lot of essential, keyboard-related types and views. By typing ``Keyboard`` and `.`, Xcode will list all essential types within this namespace.

The namespace has a lot of essential types, like ``Keyboard/Accent``, ``Keyboard/AutocapitalizationType``, ``Keyboard/BackspaceRange``, ``Keyboard/Case``, ``Keyboard/Diacritic``, ``Keyboard/InputToolbarDisplayMode``, ``Keyboard/KeyboardType``, ``Keyboard/ReturnKeyType``, etc.

The namespace also has a lot of view-related types, like ``Keyboard/Background``, ``Keyboard/Button``, ``Keyboard/ButtonStyle``, ``Keyboard/NextKeyboardButton``, ``Keyboard/SpaceContent``, ``Keyboard/Toolbar``, etc.



## Keyboard Controller

``KeyboardInputViewController`` is the most essential type in the library. Just make your **KeyboardController** inherit this class to get access to a bunch of additional capabilities and view lifecycle functions.

The ``KeyboardInputViewController`` defines shared ``KeyboardInputViewController/services``, ``KeyboardInputViewController/settings``, and ``KeyboardInputViewController/state`` properties, that can be used to avoid relying on the controller within your code.

KeyboardKit also has a ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in other platforms than UIKit.



## Keyboard Context

KeyboardKit has a ``KeyboardContext`` that provides observable keyboard state that keeps the keyboard UI up to date. It has a ``KeyboardContext/textDocumentProxy`` reference, lets you get and set ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc.

Other namespaces define other context types, like ``AutocompleteContext``, ``CalloutContext``, ``DictationContext``, etc. They will all automatically update the keyboard, provided that the keyboard view observes them.  

KeyboardKit automatically creates instances of these classes and injects them into ``KeyboardInputViewController/state``, and syncs with the controller when needed.



## Keyboard Settings

KeyboardKit has an ``KeyboardSettings`` class that provides observable keyboard settings that are automatically persisted when they are changed. Other namespaces have their own setting types, like ``AutocompleteSettings``.

KeyboardKit automatically creates instances of these classes, injects them into ``KeyboardInputViewController/settings``, and syncs any changes with the controller and its various contexts when needed.

Settings data is by default isolated to each target, but you can use ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` to automatically sync data between your app and its keyboard extension, using an App Group.

> Important: `@AppStorage` properties use the store that's available when they're first accessed. Make sure to set up a custom store BEFORE accessing any of these settings properties.


## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by some services, like the standard ``KeyboardActionHandler``, to make behavior-based decisions.

KeyboardKit automatically creates an instance of ``Keyboard/StandardBehavior`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, by implementing the procotol from scratch or by inheriting and customizing the standard behavior.



## Keyboard styling

The <doc:Styling-Article> article describes how to use a ``KeyboardStyleProvider`` to style the ``KeyboardView`` in flexible ways.

Various views have separate styles as well, that can be applied with specific view modifiers.



## Native Extensions

KeyboardKit extends native types with keyboard-specific functionality like autocomplete, text analysis, etc. Check the extension section in the bottom of the documentation root for more info.



## Keyboard View

KeyboardKit has a ``KeyboardView`` that mimics a native iOS keyboard. It can be used for alphabetic, numeric & symbolic keyboards, supports all supported locales, layouts, callouts, etc., and can be styled to great extent with styles & themes:

@Row {
    
    @Column {
        ![KeyboardView](keyboardview-english)
    }
    
    @Column {
        ![KeyboardView](keyboardview-swedish)
    }
    
    @Column {
        ![KeyboardView](keyboardview-styled)
    }
}

``KeyboardView`` can be customized to great extent. You can pass in custom services & state, replace any part of the keyboard with custom views, and enable additional components:

```swift
KeyboardView(
    controller: controller,             // You can setup the view with a controller 
    buttonContent: { $0.view },         // You can customize the content view of any button
    buttonView: { $0.view },            // You can customize the entire view of any button
    emojiKeyboard: { $0.view },         // You can customize the emoji keyboard, if any
    toolbar: { params in params.view }  // You can customize the toolbar above the keyboard
)
```

To use the standard views, just return `{ $0.view }`, or `{ params in params.view }`. Otherwise, just return the view you want to use for the provided parameters, which contain contextual information.


## Views

The ``Keyboard`` namespace has a lot of views and view-related types, like ``Keyboard/Background``, ``Keyboard/Button``, ``Keyboard/ButtonStyle``, ``Keyboard/NextKeyboardButton``, ``Keyboard/SpaceContent``, ``Keyboard/Toolbar``, etc.

@TabNavigator {
    
    @Tab("Button") {
        
        KeyboardKit has a collection of keyboard ``Keyboard/Button`` views and styles that can be used to mimic all parts of a native keyboard, as well as their gestures. The ``Keyboard/Button`` renders the full button, while other views like ``Keyboard/ButtonShadow`` renders parts of it. 
        
        ![Keyboard Button](keyboardviewbuttonpreview)

        Most of the views can be styled with a ``Keyboard/ButtonStyle``, which can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier. This is however not yet true for the ``Keyboard/Button`` itself, which uses a ``KeyboardStyleProvider`` to support more complex styling.
    }
    
    @Tab("NextKeyboardButton") {

        KeyboardKit has a ``NextKeyboardButton`` that integrates with the native keyboard switcher, to select the next keyboard on tap and show a menu with all available keyboards on long press.
        
        @Row {
            @Column {}
            @Column {
                ![NextKeyboardButton](nextkeyboardbutton)
            }
            @Column {}
        }
        
        KeyboardKit will by default map the ``KeyboardAction/nextKeyboard`` action to this view, and automatically register the required ``KeyboardInputViewController`` on launch. You just have to add a ``KeyboardAction/nextKeyboard`` button, and it will just work.  
    }
    
    @Tab("Toolbar") {
        
        KeyboardKit has a keyboard ``Keyboard/Toolbar`` that applies a minimum height to its content. It can be used to stop input & action callouts from being cut off, since a custom iOS keyboard can't render outside of its frame.
        
        ![Keyboard Toolbar](keyboardtoolbar)
        
        This view can be styled with a ``Keyboard/ToolbarStyle``, which can be applied with the ``SwiftUI/View/keyboardToolbarStyle(_:)`` view modifier:
        
        ```swift
        Keyboard.Toolbar {
            Text("Here's a toolbar")
        }
        .keyboardToolbarStyle(...)
        ```
    }
}
    
    
    
## View Styling

KeyboardKit uses view modifier-based styling to great extent. This lets you style most KeyboardKit views just like regular SwiftUI views, like how a SwiftUI `Button` can be styled with `.buttonStyle`.

This is however not (yet) implemented for more complex views, like ``KeyboardView``, which uses the ``KeyboardStyleProvider`` concept to provide dynamic styles to any part of the view hieararchy.
    
See the <doc:Styling-Article> article for more information.
    

    
## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional, powerful ``KeyboardView`` capabilities, including full support for all ``KeyboardLocale``s, a full-blown ``EmojiKeyboard``, input toolbars, powerful ``KeyboardViewPreview``s, etc.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Keyboard View

KeyboardKit Pro unlocks additional ``KeyboardView``-related views and utils, that make it easier to create more powerful keyboards:

@TabNavigator {
    
    @Tab("Bottom Row") {
        KeyboardKit Pro unlocks a ``KeyboardViewBottomRow`` component that renders a keyboard bottom row, which by default uses the same layout configuration as the full keyboard.  

        ![Keyboard View Bottom Row](keyboardviewbottomrow)
        
        This view is convenient if you want to replace the keyboard view, but keep the bottom button row.
    }
    
    @Tab("Emoji Keyboard") {
        KeyboardKit Pro unlocks an ``EmojiKeyboard``, which is automatically added to ``KeyboardView`` when a valid license is registered.

        @Row {
            @Column { }
            @Column(size: 2) {
                ![Emoji Keyboard](emojikeyboard)
            }
            @Column { }
        }
        
        The keyboard has support for categories, runtime version adjustments and skintones. Read more about this in the <doc:Emojis-Article> article.
    }
    
    @Tab("Input Toolbar") {
        KeyboardKit Pro will automatically add an input toolbar to ``KeyboardView`` if ``SwiftUI/View/keyboardInputToolbarDisplayMode(_:)`` is applied to the view hierarchy, with an ``Keyboard/InputToolbarDisplayMode/automatic`` or ``Keyboard/InputToolbarDisplayMode/inputs(_:)`` configuration.

        @Row {
            @Column {
                ![Input Row in iPad](inputtoolbar-ipad)
            }
            @Column {
                ![Input Row in iPad](inputtoolbar-ipadpro)
            }
        }
        
        The toolbar is added between the autocomplete toolbar and the keyboard, and by default uses a slightly smaller button height.
    }
    
    @Tab("Localization") {
        KeyboardKit Pro unlocks localized services for all supported ``KeyboardLocale``s, which lets you create fully localized keyboards.

        @Row {
            @Column { }
            @Column(size: 2) {
                ![KeyboardView in Swedish](keyboardview-swedish)
            }
            @Column { }
        }
        
        The various license tiers unlock different amount of ``KeyboardLocale``s, where Gold unlocks all. Read more in the <doc:Localization-Article> article.
    }
    
    @Tab("Previews") {
        KeyboardKit Pro unlocks a ``KeyboardViewPreview``, which can be used to preview various configurations, locales, themes, etc.

        @Row {
            @Column { }
            @Column(size: 2) {
                ![KeyboardView Preview](keyboardviewpreview-theme)
            }
            @Column { }
        }
        
        This view can also be used to show keyboard configurations to your users, e.g. on a settings screen. Read more in the <doc:Previews-Article> article.
    }
}


### Views

KeyboardKit Pro also unlocks more general keyboard views in the ``Keyboard`` namespace, to let you create more complex keyboards:

@TabNavigator {
    
    @Tab("ToggleToolbar") {
        
        The ``Keyboard/ToggleToolbar`` can be used to toggle between two toolbars, e.g. to place a main menu "behind" the autocomplete toolbar:
        
        ![ToggleToolbar](keyboardtoggletoolbar)
        
        This view wraps itself in a ``Keyboard/Toolbar``, which means that it can also be styled with the ``SwiftUI/View/keyboardToolbarStyle(_:)`` modifier.
    }
}

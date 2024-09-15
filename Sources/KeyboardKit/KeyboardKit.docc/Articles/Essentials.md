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

The namespace has a lot of essential types, like ``Keyboard/Accent``, ``Keyboard/AutocapitalizationType``, ``Keyboard/BackspaceRange``, ``Keyboard/Case``, ``Keyboard/Diacritic``, ``Keyboard/Gesture``, ``Keyboard/InputToolbarDisplayMode``, ``Keyboard/KeyboardType``, ``Keyboard/ReturnKeyType``, etc.

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



## Keyboard Behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by some services, like the standard ``KeyboardActionHandler``, to make behavior-based decisions.

KeyboardKit automatically creates an instance of ``Keyboard/StandardBehavior`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, by implementing the procotol from scratch or by inheriting and customizing the standard behavior.



## Keyboard Styling

The <doc:Styling-Article> article describes how to use a ``KeyboardStyleService`` to style the ``KeyboardView`` in flexible ways.

Various views have separate styles as well, that can be applied with specific view modifiers.



## Keyboard-related Extensions

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

The view can be customized to great extent. You can pass in custom services & state, and replace any button or entire sub-component:

```swift
KeyboardView(
    controller: controller,             // You can pass in a controller, or specific states and services
    buttonContent: { $0.view },         // You can customize the content view of any button
    buttonView: { $0.view },            // You can customize the entire view of any button
    emojiKeyboard: { $0.view },         // You can customize the emoji keyboard, if any
    toolbar: { params in params.view }  // You can customize the toolbar above the keyboard
)
```

Just return `{ $0.view }` or `{ params in params.view }` to use the standard view, or return a custom view for any part of the keyboard. Each view builder provides you with view-related parameters with contextual information.


## Views

The ``Keyboard`` namespace has a lot of views, styles, and view-related types:

@TabNavigator {
    
    @Tab("Keyboard View") {
        KeyboardKit has a ``KeyboardView`` that mimics a native iOS keyboard and that can be customized to great extent. Read more above.
        
        @Row {
            @Column {}
            @Column(size: 3) {
                ![Keyboard View](keyboardview-english)
            }
            @Column {}
        }
    }
    
    @Tab("Keyboard Button") {
        
        The ``Keyboard`` namespace has a set of keyboard ``Keyboard/Button`` views and styles that can be used to mimic all parts of a native keyboard, as well as their gestures. The ``Keyboard/Button`` renders the full button, while other views like ``Keyboard/ButtonShadow`` (not shown here) renders parts of it. 
        
        @Row {
            @Column {}
            @Column(size: 3) {
                ![Keyboard Button](keyboardbuttonpreview)
            }
            @Column {}
        }
    }
    
    @Tab("Keyboard Bottom Row") {
        The ``Keyboard`` namespace has a ``Keyboard/BottomRow`` that just render a bottom keyboard row, with the same behavior as a ``KeyboardView``.

        ![Keyboard Bottom Row](keyboardbottomrow)
    }
    
    @Tab("Keyboard Switcher") {

        The ``Keyboard`` namespace has a ``NextKeyboardButton`` that works as a native keyboard switcher. It switches to the next system keyboard on tap and shows a popover menu with all available keyboards on long press.
        
        @Row {
            @Column {}
            @Column {
                ![NextKeyboardButton](nextkeyboardbutton)
            }
            @Column {}
        }
    }
    
    @Tab("Keyboard Toolbar") {
        
        The ``Keyboard`` namespace has a ``Keyboard/Toolbar`` view that applies a minimum height to its content. KeyboardKit will by default always add a toolbar to the ``KeyboardView`` to avoid callouts from being cut off, since custom keyboards can't render outside of the frame.
        
        ![Keyboard Toolbar](keyboardtoolbar)
    }
}



## View Styling

Most views have a corresponding style, which can be used to style it, much like SwiftUI's `Button` has a `ButtonStyle` and `.buttonStyle(...)` view modifier, that can be applied to an individual button, or an entire view hierarchy.

In KeyboardKit, a ``Keyboard``.``Keyboard/Button`` has a ``Keyboard/ButtonStyle`` that can be applied with a ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier. The ``Keyboard/Toolbar`` has a ``Keyboard/ToolbarStyle`` and a ``SwiftUI/View/keyboardToolbarStyle(_:)`` view modifier, etc.

When you use a ``KeyboardView``, you must however use the ``KeyboardStyleService`` concept instead, since the keyboard view is so complex. You can however apply explicit styles within the ``KeyboardView``'s various view builder parameters.
    
See the <doc:Styling-Article> article for more information.
    

    
## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional, powerful ``KeyboardView`` capabilities, including full support for all ``KeyboardLocale``s, a full-blown ``EmojiKeyboard``, input toolbars, powerful ``KeyboardViewPreview``s, etc.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Views

KeyboardKit Pro unlocks additional ``Keyboard``-related views and utilities, that make it easier to create even more powerful keyboards:

@TabNavigator {
    
    @Tab("Localization") {
        KeyboardKit Pro unlocks localized services for all supported ``KeyboardLocale``s, which lets you create fully localized keyboard views that automatically shows the correct buttons, autocomplete suggestions, and callout actions.

        @Row {
            @Column { }
            @Column(size: 3) {
                ![KeyboardView in Swedish](keyboardview-swedish)
            }
            @Column { }
        }
        
        The various license tiers unlock different amount of ``KeyboardLocale``s, where Gold unlocks all. Read more in the <doc:Localization-Article> article.
    }
    
    @Tab("Emoji Keyboard") {
        KeyboardKit Pro unlocks an ``EmojiKeyboard``, which is automatically added to ``KeyboardView`` when a valid license is registered.

        @Row {
            @Column { }
            @Column(size: 3) {
                ![Emoji Keyboard](emojikeyboard)
            }
            @Column { }
        }
        
        The keyboard has support for categories, runtime version adjustments and skintones. Read more about this in the <doc:Emojis-Article> article.
    }
    
    @Tab("Input Toolbar") {
        KeyboardKit Pro will automatically add an additional input toolbar above ``KeyboardView`` on large iPad devices, which makes it easy to insert numeric values without switching keyboard type.

        @Row {
            @Column { }
            @Column(size: 3) {
                ![Input Row in iPad](inputtoolbar-ipad)
            }
            @Column { }
        }
        
        You can apply a ``SwiftUI/View/keyboardInputToolbarDisplayMode(_:)`` modifier to the keyboard view to control whether to show or hide the toolbar on all device types, or to customize the buttons on the input keyboard.
    }
    
    @Tab("Toggle Toolbar") {
        
        The ``Keyboard/ToggleToolbar`` can be used to toggle between two toolbars, e.g. to place a main menu "behind" the autocomplete toolbar:
        
        ![ToggleToolbar](keyboardtoggletoolbar)
        
        This view wraps itself in a ``Keyboard/Toolbar``, which means that it can also be styled with the ``SwiftUI/View/keyboardToolbarStyle(_:)`` modifier.
    }
}


### Previews

KeyboardKit Pro also unlocks ``Keyboard``-related previews, that can be used to preview ``KeyboardView`` and ``Keyboard``.``Keyboard/Button`` for various configurations, locales, styles, themes, etc.

@TabNavigator {
    
    @Tab("Keyboard View") {
        KeyboardKit Pro unlocks a ``KeyboardViewPreview`` that can preview the ``KeyboardView`` for various locales, styles, themes, etc.

        @Row {
            @Column {
                ![KeyboardView Preview - Swedish](keyboardview-swedish)
            }
            @Column {
                ![KeyboardView Preview - Turkish](keyboardviewpreview)
            }
            @Column {
                ![KeyboardView Preview - Theme](keyboardviewpreview-theme)
            }
        }
    }
    
    @Tab("Keyboard Button") {
        KeyboardKit Pro also unlocks a ``Keyboard``.``Keyboard/ButtonPreview`` view that can be used to preview a ``Keyboard``.``Keyboard/Button``, which is a lot more performant than the full ``KeyboardViewPreview``.

        @Row {
            @Column { }
            @Column(size: 3) {
                ![Keyboard Button Preview](keyboardbuttonpreview)
            }
            @Column { }
        }
    }
}

These previews can be used in the main application, to show users how the keyboard will look for different settings, styles, themes, etc.

You can read more about previews in the <doc:Previews-Article> article.

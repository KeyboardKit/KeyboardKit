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

KeyboardKit also has a ``SystemKeyboard`` view that mimics the native iOS keyboard and can be customized & styled to great extent. Many of the tools and views in the SDK are used by the system keyboard.

👑 [KeyboardKit Pro][Pro] unlocks a lot of essential Pro features, such as a toggle toolbar, a system keyboard input toolbar, additional system keyboard views, previews, etc. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Keyboard namespace

KeyboardKit has a ``Keyboard`` namespace with a lot of keyboard-related types, such as ``Keyboard/AutocapitalizationType``, ``Keyboard/BackspaceRange``, ``Keyboard/Case``, ``Keyboard/KeyboardType``, ``Keyboard/ReturnKeyType``, etc. 

Namespaces are used to make the surface API smaller, by nesting types together in logical groups. By typing ``Keyboard`` and `.`, Xcode will provide you with a convenient list of types that are included in this essential namespace.

The same goes for other namespaces, like ``KeyboardAction``, ``KeyboardLayout``, ``Callouts``, ``Feedback``, etc. Most related types are nested in each namespace, except for protocols and important top-level types. 



## Keyboard input view controller

``KeyboardInputViewController`` is the most essential type in the library. Just make your **KeyboardController** inherit this class to get access to a bunch of additional capabilities and view lifecycle functions.

KeyboardKit also has a ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in platforms that don't support UIKit. This is however not fully implemented yet, although many types use it.



## Keyboard context

KeyboardKit has an ``KeyboardContext`` class that provides observable keyboard state that keeps the keyboard UI up to date with its current state. It has a ``KeyboardContext/textDocumentProxy`` reference and lets you get and set ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc.

You can use this type control the keyboard. For instance, setting the ``KeyboardContext/keyboardType`` will update the ``SystemKeyboard`` accordingly.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, and syncs it with the controller whenever needed.



## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by some services, like the standard ``KeyboardActionHandler``, to make behavior-based decisions.

KeyboardKit automatically creates an instance of ``Keyboard/StandardBehavior`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, by implementing the procotol from scratch or by inheriting and customizing the standard behavior.



## Keyboard appearance

A keyboard appearance is used to determine if a keyboard is light or dark. This is not the same thing as the *color scheme*. A keyboard can be defined as "dark" even in light mode, and will render slightly darker than the default keyboard.

KeyboardKit has an ``Keyboard/AppearanceViewModifier`` that can be applied with the ``SwiftUI/View/keyboardAppearance(_:)`` view modifier:

```
TextField("Enter text", text: $text)
    .keyboardAppearance(.dark)
```

Note that applying a dark appearances will make iOS tell the extension that the *color scheme* is dark, while this may in fact not be true. This will lead to visual bugs, that require workarounds. See the <doc:Colors-Article> article for more information.



## Extensions

KeyboardKit extends native types with a lot more information, to make it easier to implement features like autocomplete, text analysis, etc. Check the extension section in the bottom of the documentation root, or the `Extensions` folder for more info.

For instance, KeyboardKit extends types in ``Foundation``, ``Swift``, ``SwiftUI``, and other platform-specific frameworks.



## System Keyboard

KeyboardKit has a ``SystemKeyboard`` that mimics a native iOS keyboard. It can be used for alphabetic, numeric & symbolic keyboards, 
supports all supported locales, layouts, callouts, etc., and can be styled to great extent with styles & themes:

@Row {
    
    @Column {
        ![SystemKeyboard](systemkeyboard-english-350.jpg)
    }
    
    @Column {
        ![SystemKeyboard](systemkeyboard-swedish-350.jpg)
    }
    
    @Column {
        ![SystemKeyboard](systemkeyboard-styled-350.jpg)
    }
}

``SystemKeyboard`` can be customized to great extent. You can pass in custom services & state, replace any part of the keyboard, and enable additional components:

```swift
SystemKeyboard(
    controller: controller,             // You can setup the view with a controller instance 
    buttonContent: { $0.view },         // Can be used to customize the content view of any button
    buttonView: { $0.view },            // Can be used to customize the entire view of any button
    emojiKeyboard: { $0.view },         // Can be used to customize the emoji keyboard, if any
    toolbar: { params in params.view }  // Can be used to customize the toolbar above the keyboard
)
```

To use the standard views, just return `{ $0.view }`, or `{ params in params.view }`. Otherwise, just return the view you want to use for the provided parameters, which contain contextual information.


## Views

KeyboardKit also provides gerneral, keyboard-specific views in the ``Keyboard`` namespace, which means that you need to prefix the names below with `Keyboard.` when using them:

@TabNavigator {
    
    @Tab("Button") {
        
        KeyboardKit has a collection of keyboard ``Keyboard/Button`` views and styles that can be used to mimic all parts of a native keyboard, as well as their gestures. The ``Keyboard/Button`` renders the full button, while other views like ``Keyboard/ButtonShadow`` renders parts of it. 
        
        ![Keyboard Button](systemkeyboardbuttonpreview.jpg)

        Most of the views can be styled with a ``Keyboard/ButtonStyle``, which can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier. This is however not yet true for the ``Keyboard/Button`` itself, which uses a ``KeyboardStyleProvider`` to support more complex styling.
    }
    
    @Tab("NextKeyboardButton") {

        KeyboardKit has a ``NextKeyboardButton`` that can be used to integrate with the iOS keyboard switcher, to select the next keyboard on tap and shows a keyboard menu on long press.
        
        @Row {
            @Column {}
            @Column {
                ![NextKeyboardButton](nextkeyboardbutton.jpg)
            }
            @Column {}
        }

        This button requires a ``Keyboard/NextKeyboardController`` to trigger controller-based functionality that switches keyboard and shows the menu. KeyboardKit automatically registers the ``KeyboardInputViewController`` when it launches.

        KeyboardKit will by default map ``KeyboardAction/nextKeyboard`` to this view when rendering the action, which means that you don't have to do this.
    }
    
    @Tab("Toolbar") {
        
        KeyboardKit has a keyboard ``Keyboard/Toolbar`` that applies a minimum height to its content. It can be used to stop input & action callouts from being cut off, since a custom iOS keyboard can't render outside of its frame.
        
        ![Keyboard Toolbar](keyboardtoolbar.jpg)
        
        This view can be styled with a ``Keyboard/ToolbarStyle``, which can be applied with the ``SwiftUI/View/keyboardToolbarStyle(_:)`` view modifier:
        
        ```swift
        Keyboard.Toolbar {
            Text("Here's a toolbar")
        }
        .keyboardToolbarStyle(...)
        ```
    }
}
    
See the <doc:Styling-Article> article for more information about KeyboardKit view styling.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional, powerful capabilities for the ``SystemKeyboard``, including full support for every ``KeyboardLocale``, a full-blown ``EmojiKeyboard``, input toolbars, powerful ``SystemKeyboardPreview``s, etc.

See the <doc:Localization-Article>, <doc:Emojis-Article> and <doc:Previews-Article> articles for more information about these features.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### System Keyboard

KeyboardKit Pro unlocks additional ``SystemKeyboard``-related views and utils, that make it easier to create more powerful keyboards:

@TabNavigator {
    
    @Tab("SystemKeyboardBottomRow") {
        KeyboardKit Pro unlocks a ``SystemKeyboardBottomRow`` component that can be used to just render a system keyboard bottom row that by default uses the same layout configuration as the full system keyboard.  

        ![System Keyboard Bottom Row](systemkeyboardbottomrow)
        
        This view is convenient if you want to replace the system keyboard with another view, but keep a bottom button row with some actions. 
    }
    
    @Tab("SystemKeyboardInputToolbar") {
        KeyboardKit Pro will automatically add an input toolbar to ``SystemKeyboard`` if ``SwiftUI/View/keyboardInputToolbarDisplayMode(_:)`` is applied to the view hierarchy, with an ``Keyboard/InputToolbarDisplayMode/automatic`` or ``Keyboard/InputToolbarDisplayMode/inputs(_:)`` configuration.

        @Row {
            @Column {
                ![Input Row in iPad](inputtoolbar-ipad)
            }
            @Column {
                ![Input Row in iPad](inputtoolbar-ipadpro)
            }
        }
        
        The toolbar is added between the autocomplete toolbar and the system keyboard, and by default uses a slightly smaller button height.
    }
}


### Views

KeyboardKit Pro also unlocks more general keyboard views in the ``Keyboard`` namespace:

@TabNavigator {
    
    @Tab("ToggleToolbar") {
        
        The ``Keyboard/ToggleToolbar`` can be used to toggle between two toolbars, e.g. to place a main menu "behind" the autocomplete toolbar:
        
        ![ToggleToolbar](keyboardtoggletoolbar.jpg)
        
        This view wraps itself in a ``Keyboard/Toolbar``, which means that it can also be styled with the ``SwiftUI/View/keyboardToolbarStyle(_:)`` modifier.
    }
}

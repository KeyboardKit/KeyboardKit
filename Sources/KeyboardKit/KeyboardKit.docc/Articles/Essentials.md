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

The essential goal for KeyboardKit is to make it easier to create powerful and flexible keyboards. As such, it has a bunch of essential tools and view, and extensions to native types, to make the native APIs more powerful.

KeyboardKit also has a ``SystemKeyboard`` view that mimics the native iOS keyboard and can be customized & styled to great extent. Much of the views in the SDK are not used directly when you use a system keyboard.

👑 [KeyboardKit Pro][Pro] unlocks a lot of essential Pro features. Information about these features can be found at the end of each article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Keyboard namespace

KeyboardKit has a ``Keyboard`` namespace with a lot of keyboard-related types, such as ``Keyboard/AutocapitalizationType``, ``Keyboard/BackspaceRange``, ``Keyboard/Case``, ``Keyboard/KeyboardType``, ``Keyboard/ReturnKeyType``, etc. 

Namespaces are used to make the surface API smaller, by nesting types together in logical groups. By typing ``Keyboard`` followed by a `.`, Xcode will provide you with a convenient list of types that are included in this essential namespace. 



## Keyboard input view controller

``KeyboardInputViewController`` is the most essential type in the library. Just make your **KeyboardController** inherit this class to get access to a bunch of additional capabilities and view lifecycle functions.

KeyboardKit also has a ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in platforms that don't support UIKit. This is however not fully implemented yet.



## Keyboard context

KeyboardKit has an ``KeyboardContext`` class that provides observable keyboard state that keeps the keyboard UI up to date with its current state. It has a ``KeyboardContext/textDocumentProxy`` reference and lets you get and set ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc.

You can use this type control the keyboard. For instance, setting the ``KeyboardContext/keyboardType`` will update the ``SystemKeyboard`` accordingly.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, and syncs it with the controller whenever needed.



## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by some services, like the standard ``KeyboardActionHandler``, to make behavior-based decisions.

KeyboardKit automatically creates an instance of ``Keyboard/StandardBehavior`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, by implementing the procotol from scratch or by inheriting and customizing the standard behavior.



## Extensions

KeyboardKit extends native types with a lot more information, to make it easier to implement features like autocomplete, text analysis, etc. Check the extension section in the bottom of the documentation root, or the `Extensions` folder for more info.



## Views

KeyboardKit provides essential views that can be used to create keyboards that mimic the native system keyboards for iOS and iPadOS.

@TabNavigator {
    
    @Tab("SystemKeyboard") {
        
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

        ``SystemKeyboard`` can be customized to great extent. You can pass in custom services & state, and replace any part of the keyboard:

        ```swift
        SystemKeyboard(
            controller: controller,             // You can setup the view with a controller instance 
            buttonContent: { $0.view },         // Can be used to customize the content view of any button
            buttonView: { $0.view },            // Can be used to customize the entire view of any button
            emojiKeyboard: { $0.view },         // Can be used to customize the emoji keyboard, if any
            toolbar: { params in params.view }  // Can be used to customize the toolbar above the keyboard
        )
        ```

        To use the standard views, just return `{ $0.view }`, or `{ params in params.view }`. Otherwise, just return the view you want to use for the provided params. The view builders provide information to help you setup custom views.
    }
    
    @Tab("Keyboard.Button") {
        
        KeyboardKit has a collection of keyboard ``Keyboard/Button`` views and styles that can be used to mimic all parts of a native keyboard buttons, as well as their gestures. The ``Keyboard/Button`` renders the full button, while views like ``Keyboard/ButtonShadow`` renders parts of it. 
        
        ![Keyboard Button](systemkeyboardbuttonpreview-350.jpg)

        Most of the views can be styled with a ``Keyboard/ButtonStyle``, which can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier. This is however not yet true for the ``Keyboard/Button`` itself, which uses a ``KeyboardStyleProvider`` to support more complex styling.
    }
    
    @Tab("Keyboard.NextKeyboardButton") {

        KeyboardKit has a ``NextKeyboardButton`` that can be used to integrate with the iOS keyboard switcher, to select the next keyboard on tap and shows a keyboard menu on long press.

        ![NextKeyboardButton](nextkeyboardbutton-250.jpg)

        This button requires a ``Keyboard/NextKeyboardController`` to trigger controller-based functionality that switches keyboard and shows the menu. KeyboardKit automatically registers the ``KeyboardInputViewController`` when it launches.

        KeyboardKit will by default map ``KeyboardAction/nextKeyboard`` to this view when rendering the action, which means that you don't have to do this.
    }
    
    @Tab("Keyboard.Toolbar") {
        
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
    
See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional, powerful capabilities for the ``SystemKeyboard``, such as support for every ``KeyboardLocale``, an ``EmojiKeyboard``, and powerful ``SystemKeyboardPreview`` and ``SystemKeyboardButtonPreview`` view.

See the <doc:Localization-Article>, <doc:Emojis-Article> and <doc:Previews-Article> articles for more information.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

### Views

KeyboardKit Pro adds more views to the SDK, to let you build more complex keyboards with fewer lines of code.

@TabNavigator {
    
    @Tab("Keyboard.ToggleToolbar") {
        
        The ``Keyboard/ToggleToolbar`` can toggle between two toolbars. It's a great way to place a main menu "behind" the autocomplete toolbar, and let it slide in when tapping the customizable toggle.
        
        ![ToggleToolbar](keyboardtoggletoolbar.jpg)
        
        This view wraps itself in a ``Keyboard/Toolbar``, which means that it can also be styled with the ``SwiftUI/View/keyboardToolbarStyle(_:)`` modifier.
    }
}

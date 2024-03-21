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

KeyboardKit also has a ``SystemKeyboard`` view that mimics the native iOS keyboard and can be customized & styled to great extent.

[KeyboardKit Pro][Pro] unlocks a lot of essential Pro features. Information about these features can be found at the end of each article. Every article in this documentation describes what KeyboardKit Pro adds to that particular part.



## Keyboard namespace

KeyboardKit has a ``Keyboard`` namespace with a lot of keyboard-related types, such as ``Keyboard/AutocapitalizationType``, ``Keyboard/BackspaceRange``, ``Keyboard/Case``, ``Keyboard/KeyboardType``, ``Keyboard/ReturnKeyType``, etc. 

Namespaces are used to make the surface API smaller, by nesting types together in logical groups. By typing ``Keyboard`` followed by a `.`, Xcode will provide you with a convenient list of types that are included in this essential namespace. 

This namespace doesn't contain protocols, open classes or types of higher importance.



## Keyboard input view controller

``KeyboardInputViewController`` is the most essential type in the library. Just make your **KeyboardController** inherit this class to get access to a bunch of additional capabilities and view lifecycle functions.

KeyboardKit also has a ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in platforms that don't support UIKit. This is however not fully implemented yet.



## Keyboard context

KeyboardKit has an ``KeyboardContext`` class that provides observable keyboard state that keeps the keyboard UI up to date with its current state. It has a ``KeyboardContext/textDocumentProxy`` reference and lets you get and set ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc.

You can use this type control the keyboard. For instance, setting the ``KeyboardContext/keyboardType`` will update the ``SystemKeyboard`` accordingly.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, and syncs it with the controller whenever needed.



## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by e.g. the ``StandardKeyboardActionHandler`` to make behavior-based decisions.

KeyboardKit automatically creates a ``StandardKeyboardBehavior`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time.



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
    
    @Tab("Keyboard Button") {
        
        KeyboardKit has a collection of ``Keyboard`` ``Keyboard/Button`` views and styles that can be used to mimic native iOS keyboard buttons, as well as their native gestures and behavior.
        
        ![Keyboard Button](systemkeyboardbuttonpreview-350.jpg)

        Most of the views can be styled with a ``Keyboard/ButtonStyle``, which can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier. This is however not yet true for the ``Keyboard/Button`` itself, which uses a ``KeyboardStyleProvider`` to support more complex styling. 
        
        See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.
    }
    
    @Tab("Keyboard Toolbar") {
        
        KeyboardKit has a ``Keyboard`` ``Keyboard/Toolbar`` that applies a minimum height to its content. This can be used to stop input & action callouts from being cut off, since a custom iOS keyboard can't render outside of its frame.
        
        ![Keyboard Toolbar](autocompletetoolbar.jpg)
        
        This view can be styled with a ``Keyboard/ToolbarStyle``, which can be applied with the ``SwiftUI/View/keyboardToolbarStyle(_:)`` view modifier:
        
        ```swift
        Keyboard.Toolbar {
            Text("Here's a toolbar")
        }
        .keyboardToolbarStyle(...)
        ```
    }
    
    @Tab("Next Keyboard Button") {

        KeyboardKit has a ``Keyboard`` ``NextKeyboardButton`` that be used to integrate with the iOS keyboard switcher, which selects the next keyboard when tapped and shows a keyboard menu when being long pressed.

        ![NextKeyboardButton](nextkeyboardbutton-250.jpg)

        This button requires a ``Keyboard/NextKeyboardController`` to trigger controller-based functionality that switches keyboard and shows the menu. KeyboardKit automatically registers the ``KeyboardInputViewController`` when it launches.

        KeyboardKit will by default map ``KeyboardAction/nextKeyboard`` to this view when rendering the action, which means that you don't have to do this.

    }
}



## 👑 Pro features

KeyboardKit Pro unlocks additional, powerful capabilities for the ``SystemKeyboard``.

@TabNavigator {
    
    @Tab("Locales") {
        @Row {
            @Column {
                ![SystemKeyboard](systemkeyboard-swedish-350.jpg)
            }
            @Column(size: 2) {
                #### Locales

                KeyboardKit Pro unlocks layouts, callouts, and services for all ``KeyboardLocale``s. This means that you can support up to 63 locales without any additional code.
                
                See the <doc:Localization-Article> article for more information.
            }
        }
    }
    
    @Tab("Emojis") {
        @Row {
            @Column {
                ![EmojiKeyboard](emojikeyboard-350.jpg)
            }
            @Column(size: 2) {
                #### Emojis

                KeyboardKit Pro Gold unlocks a full **EmojiKeyboard** and makes ``SystemKeyboard`` use it as the default emoji keyboard.
                
                See the <doc:Emojis-Article> article for more information.
            }
        }
    }
    
    @Tab("Previews") {
        @Row {
            @Column {
                ![SystemKeyboardPreview](systemkeyboardpreview-theme-350.jpg)
                
                ![SystemKeyboardButtonPreview](systemkeyboardbuttonpreview-350.jpg)
            }
            @Column(size: 2) {
                #### Previews

                KeyboardKit Pro Gold unlocks a **SystemKeyboardPreview** view that can be used to show how different locales, styles, configurations & themes affect the keyboard. 
                
                KeyboardKit Pro Gold also unlocks a more performant **SystemKeyboardButtonPreview** that lets you preview separate buttons in powerful ways.
                
                See the <doc:Previews-Article> article for more information.
            }
        }
    }
}


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

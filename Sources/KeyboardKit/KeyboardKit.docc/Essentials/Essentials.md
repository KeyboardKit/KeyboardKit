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

This namespace doesn't have protocols, open classes, or types that are meant to be top-level.



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

This section describes essential views in the KeyboardKit library.

@TabNavigator {
    
    @Tab("System Keyboard") {
        
        KeyboardKit has a ``SystemKeyboard`` that mimics a native iOS keyboard. It can be used for alphabetic, numeric & symbolic keyboards.
        
        It supports all ``KeyboardLocale``s, custom layouts, callouts, and can be customized and styled to great extent with styles and themes:

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
    
    @Tab("Toolbar") {
        
        Unlike native keyboards, custom iOS keyboards can't expand beyond the keyboard frame. As such, it's always a good idea to have at least 50 points above the keyboard, to avoid cutting off the input and action callouts that the keyboard can present.
        
        The Keyboard namespace therefore has a ``Keyboard/Toolbar`` that applies a minimum height to its content. It can be styled with a ``Keyboard/ToolbarStyle``, which is applied with a `.keyboardToolbarStyle` view modifier:
        
        ```swift
        VStack(spacing: 0) {
            Keyboard.Toolbar {
                Text("Here's a toolbar")
            }
        }
        .keyboardToolbarStyle(...)
        ```
    }
}




## 👑 Pro features

KeyboardKit Pro unlocks additional, powerful capabilities for the ``SystemKeyboard``.

@Row {
    @Column {
        ![SystemKeyboard](systemkeyboard-swedish-350.jpg)
    }
    @Column(size: 2) {
        ### Locales

        KeyboardKit Pro unlocks layouts, callouts, and services for all ``KeyboardLocale``s. This means that you can support up to 63 locales without any additional code.
        
        See the <doc:Localization-Article> article for more information.
    }
}

@Row {
    @Column {
        ![EmojiKeyboard](emojikeyboard-350.jpg)
    }
    @Column(size: 2) {
        ### Emoji Keyboard

        KeyboardKit Pro Gold unlocks an **EmojiKeyboard** view and makes ``SystemKeyboard`` use it as the default emoji keyboard.
        
        This means that by just registering a valid license key, your keyboard will automatically show an emoji keyboard when ``KeyboardContext/keyboardType`` changes to ``Keyboard/KeyboardType/emojis``.
        
        See the <doc:Emojis-Article> article for more information.
    }
}

@Row {
    @Column {
        ```swift
        SystemKeyboardPreview(
            theme: try? .candyShop
        )
        ```
    }
    @Column(size: 2) {
        ### System Keyboard Preview

        KeyboardKit Pro unlocks a **SystemKeyboardPreview** that can preview different styles, configurations and themes. 
        
        This is a regular view that you can place anywhere, even in your main app.
        
        See the <doc:Previews-Article> article for more information.
    }
}



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

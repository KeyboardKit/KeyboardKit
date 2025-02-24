# Text Input

This article describes the KeyboardKit text input engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Custom iOS keyboards use a ``UIKit/UITextDocumentProxy`` to modify text, move the input cursor, provide input-related information, etc. 

This proxy will by default point to the currently selected text field in the currently active app, and will *not* detect if you select a text field inside the keyboard. Even if you focus on a text field within the keyboard, text will still be sent to the text field in the currently active app.

KeyboardKit Pro unlocks text input views that let you type directly within a custom keyboard extension. This makes it easy to implement text-based features, like search, AI prompting, etc.



## Text Input 

KeyboardKit adds ways to make text routing easier. For instance, ``KeyboardContext`` has a custom ``KeyboardContext/textInputProxy`` that can be set to route text to any other text field or custom proxy.

You can set ``KeyboardContext/textInputProxy`` to any custom proxy to start routing text to that proxy instead of the currently active app, and set it to nil to resume using the active app. You can always access the original text document proxy with ``KeyboardInputViewController/originalTextDocumentProxy``.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a ``KeyboardTextField`` and ``KeyboardTextView`` that automatically register themselves as ``KeyboardContext/textInputProxy`` when they get focus. Use them to type directly within a keyboard extension without any additional code.

KeyboardKit Pro also unlocks additional ``KeyboardTextInput`` support, like ``KeyboardTextInput/Vietnamese``, to let you to type in locale-specific ways.



### 🇻🇳 Vietnamese

KeyboardKit Pro unlocks support for ``KeyboardTextInput/Vietnamese`` TELEX, VIQR, and VNI. This support is based on Vietnamese-specific ``Keyboard/Diacritic`` values and locale-specific types in the Vietnamese namespace. 

KeyboardKit Pro will automatically use Vietnamese input when applicable. You can use the Vietnamese-specific diacritics and types as standalone features to implement Vietnamese typing support elsewhere. 

> Note: Vietnamese typing support requires at least a `Silver` license.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Views

@TabNavigator {
    
    @Tab("KeyboardTextField") {
        The ``KeyboardTextField`` component wraps a native text field and can be used for single-line text input inside a keyboard extension.
    }
    
    @Tab("KeyboardTextView") {
        The ``KeyboardTextView`` component wraps a native text view and can be used for multi-line text input inside a keyboard extension.
    }
}

Both views support `@FocusState`, and have a custom ``SwiftUICore/View/focused(_:doneButton:)`` view modifier that lets you provide a custom done button that slides in when the view is focused, and can be tapped to end editing:

```swift
struct CustomKeyboardToolbar: View {

    unowned var controller: KeyboardInputViewController

    @State 
    private var text = ""

    @FocusState 
    private var isTextFieldFocused

    var body: some View {
        if hasFullAccess {
            KeyboardTextField(
                "Type here...", 
                text: $text, 
                controller: controller,
                config: configureTextField,
                onSubmit: handleReturnKeyPressed    
                // Use onSubmit: to detect the return key.
                // The onSubmit(...) view modifier doesn't work.
            )
            .focused($isTextFieldFocused) {
                Image(systemName: "xmark.circle.fill")
            }
        }
    }
    
    func configureTextField(_ view: UITextField) {
        // Configure the underlying view in any way you want.
    }
    
    func handleReturnKeyPressed() {
        print("Return key pressed!")
    }
}
```

> Note: These views require at least a `Silver` license.

> Important: These views require Full Access, due to an iOS bug that causes a crash when using them while Full Access is disabled. They will automatically disable themselves when Full Access is disabled.

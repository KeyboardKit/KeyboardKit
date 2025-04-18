# Input

This article describes the KeyboardKit input engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Custom iOS keyboards use a ``UIKit/UITextDocumentProxy`` to modify text, move the input cursor, provide input-related information, etc. 

This proxy points to the currently selected text field in the currently active app, and will *not* detect if you focus on a text field inside the keyboard extension. Text that you type will still be sent to the currently active app.

KeyboardKit Pro unlocks text input views that let you type directly within a keyboard extension, as well as ``Vietnamese`` input support.



## Text routing  

The ``KeyboardContext`` has a custom ``KeyboardContext/textInputProxy`` that can be set to route text to any other text field or custom proxy. You can always access the original text document proxy with the ``KeyboardContext/originalTextDocumentProxy`` property.

The ``KeyboardInputViewController`` has similar properties, but you should avoid referring to it and passing it within your code.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a ``KeyboardTextField`` and ``KeyboardTextView`` that let you type directly within a keyboard extension by automatically registering themselves as ``KeyboardContext/textInputProxy`` when they get focus

KeyboardKit Pro also unlocks additional ``KeyboardTextInput`` support, like ``Vietnamese``, to let you to type in locale-specific ways.



### 🇻🇳 Vietnamese Input (BETA)

KeyboardKit Pro unlocks a ``Vietnamese`` namespace, with Vietnamese-related types, as well as a  ``VietnameseInputEngine`` that supports typing with TELEX, VIQR, and VNI. 

KeyboardKit Pro will automatically use the ``VietnameseInputEngine`` when applicable. You can also use these types as standalone features to implement Vietnamese input support elsewhere.

> Important: Vietnamese typing requires a `Gold` license.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Input Views

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

> Note: The ``KeyboardTextField`` and ``KeyboardTextView`` require at least a `Silver` license.

> Important: These views require Full Access, due to an iOS bug that causes a crash when using them while Full Access is disabled. They will automatically disable themselves when Full Access is disabled.

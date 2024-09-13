# Text Input

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit text input engine, which lets you type within the keyboard extension.

iOS keyboard extensions use a ``UIKit/UITextDocumentProxy`` to insert and delete text, move the text input cursor, etc. This proxy will by default point to the currently selected text field in the currently active app.

Keyboard extensions will by default only send text to this proxy, and will *not* detect if you select a text field inside the keyboard. Even if you focus on a text field within the keyboard, text will still be sent to the text document proxy.

These limitations make it hard to implement features that require text input in the keyboard, like emoji search, and AI-based features.



## How to route text with KeyboardKit 

KeyboardKit adds ways to make text routing easier. ``KeyboardInputViewController`` has a custom ``KeyboardInputViewController/textInputProxy`` that can be set to automatically route text to any other text field or custom proxy.

Just set ``KeyboardInputViewController/textInputProxy`` to start routing text to that proxy, and set it to nil to resume routing text to the active application. You can always access the original proxy with ``KeyboardInputViewController/originalTextDocumentProxy``.

👑 [KeyboardKit Pro][Pro] unlocks a ``KeyboardTextField`` and a ``KeyboardTextView`` that both automatically register and unregister as input proxy when they get and lose focus. Information about Pro features can be found at the end of this article.




## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks text input components that automatically register and unregister themselves as the main text input proxy when they receive and lose focus.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


## Views

@TabNavigator {
    
    @Tab("KeyboardTextField") {
        The ``KeyboardTextField`` component wraps a native text field and can be used for single-line text input inside a keyboard extension.
    }
    
    @Tab("KeyboardTextView") {
        The ``KeyboardTextView`` component wraps a native text view and can be used for multi-line text input inside a keyboard extension.
    }
}

Both views support `@FocusState`, and have a custom ``SwiftUI/View/focused(_:doneButton:)`` view modifier that lets you provide a custom done button that slides in when the view is focused, and can be tapped to end editing:

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

> Tip: The default `.onSubmit { ... }` view modifier doesn't work for these text views. If you want to detect when the return key is pressed, you can instead pass in `onSubmit:` in the initializer.

> Important: These views require at least a `Silver` license. They also require Full Access, due to an iOS bug that causes a crash when using them while Full Access is disabled. They will automatically disable themselves when Full Access is disabled.

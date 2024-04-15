# Text Input Support

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit text input engine.

iOS keyboard extensions use a ``UIKit/UITextDocumentProxy`` to interact with the currently selected text field, e.g. to insert or delete text, move the input cursor, etc. This proxy by default points to the currently selected text field in the *currently active app*.

Keyboard extensions will by default *only* send text to this text field, and will *not* detect if you select a text field within the keyboard. Even if you focus on a text field within the keyboard extension, text will still be sent to the currently active app.

These limitations make it hard to implement features that require text input in the keyboard, like emoji search, and AI-based features.

KeyboardKit adds ways to make text routing easier. ``KeyboardInputViewController`` has a custom ``KeyboardInputViewController/textInputProxy`` that can be set to automatically route text to any other text field or custom proxy.

👑 [KeyboardKit Pro][Pro] unlocks a ``KeyboardTextField`` that automatically registers and unregisters as the input proxy when it gets and loses focus. Information about Pro features can be found at the end of this article.



## How to route text with KeyboardKit

``KeyboardInputViewController`` has a ``KeyboardInputViewController/textInputProxy`` that can be set to override ``KeyboardInputViewController/textDocumentProxy`` as the main text document proxy. Setting it will cause any text you type to be sent to that proxy instead of the original one. 

Just set ``KeyboardInputViewController/textInputProxy`` to nil to restore the original proxy and resume routing text to the main application. You can always access the original proxy with ``KeyboardInputViewController/originalTextDocumentProxy``.  



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks text input components that automatically register and unregister themselves as the main text input proxy when they receive and lose focus.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


## Views

@TabNavigator {
    
    @Tab("KeyboardTextField") {
        The ``KeyboardTextField`` component wraps a native text field and can be used for single-line text inputs.
    }
    
    @Tab("KeyboardTextView") {
        The ``KeyboardTextView`` component wraps a native text view and can be used for multi-line text inputs.
    }
}

Note that you can use ``KeyboardTextField`` for both single- & multi-line text inputs in later versions of iOS. ``KeyboardTextView`` will be deprecated in a future version of KeyboardKit. 

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

> Note: The default `.onSubmit { ... }` view modifier doesn't work for these text views. If you want to detect when the return key is pressed, you can instead pass in `onSubmit:` in the initializer.

> Important: This view requires Full Access and will automatically disable itself when it's disabled, due to an iOS bug that causes a crash when using text field while Full Access is disabled.

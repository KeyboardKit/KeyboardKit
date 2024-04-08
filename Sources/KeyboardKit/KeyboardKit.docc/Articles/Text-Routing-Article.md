# Text Routing

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit text routing engine.

Custom iOS keyboard extensions use ``UIKit/UITextDocumentProxy`` to interact with the currently selected text field, e.g. to insert or delete text, move the input cursor, etc.

Keyboard extensions will however *not* send text to text fields *within* your keyboard by default. Even if you focus on a text field within the keyboard, the text will still be sent to the selected text field in the currently active app.

These limitations make it hard to implement features that require text input in the keyboard, like emoji search, and AI-based features.

KeyboardKit therefore adds ways to make text routing easier. ``KeyboardInputViewController`` has a custom ``KeyboardInputViewController/textInputProxy`` that can be set to route text to any other text field.

👑 [KeyboardKit Pro][Pro] unlocks even more text routing utils, like a ``KeyboardTextField`` that automatically registers and unregisters as the input proxy when it gets and loses focus. Information about Pro features can be found at the end of this article.



## How to route text with KeyboardKit

``UIKit/UITextDocumentProxy`` has a native textDocumentProxy, which is how a keyboard extension by default interacts with the currently selected text field, e.g. to insert or delete text, move the input cursor, etc.

``KeyboardInputViewController`` has a ``KeyboardInputViewController/textInputProxy`` that can be set to override ``KeyboardInputViewController/textDocumentProxy`` as the main text document proxy. Setting it will cause any text you type to be sent to that proxy instead of the original one. 

Just set ``KeyboardInputViewController/textInputProxy`` to **nil** to restore the original proxy and start routing text back to the main application. You can also always access the original proxy with ``KeyboardInputViewController/originalTextDocumentProxy``.  



## 👑 KeyboardKit Pro

KeyboardKit Pro unlocks text input components that automatically register and unregister themselves as the main text input proxy when they receive and lose focus.


## Views

@TabNavigator {
    
    @Tab("KeyboardTextField") {
        The ``KeyboardTextField`` component wraps a native text field and can be used for single-line text inputs.
    }
    
    @Tab("KeyboardTextView") {
        The ``KeyboardTextView`` component wraps a native text view and can be used for multi-line text inputs.
    }
}

Note that you can also use the ``KeyboardTextField`` text field configuration block to enable multiline support on later iOS versions.

Both views support `@FocusState`, and have a custom focused view modifier that lets you provide a custom done button that will slide in when the view is focused, and can be tapped to dismiss the text field:

```swift
struct CustomKeyboardToolbar: View {

    unowned var controller: KeyboardInputViewController

    @State 
    private var text = ""

    @FocusState 
    private var isTextFieldFocused

    var body: some View {
        if hasFullAccess {
            KeyboardTextField(text: $text, controller: controller) {
                $0.placeholder = "Type here..." // UITextField config
            }
            .focused($isTextFieldFocused) {
                Image(systemName: "xmark.circle.fill")
            }
        }
    }
}
```

> Important: This view requires Full Access and will automatically disable itself when it's disabled, due to an iOS bug that causes a crash when using text field while Full Access is disabled. 




[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

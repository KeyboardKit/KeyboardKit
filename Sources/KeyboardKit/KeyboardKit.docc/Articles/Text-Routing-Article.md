# Text Routing

This article describes the KeyboardKit text routing engine.

iOS keyboard extensions use the native **UITextDocumentProxy** to interact with the currently active application's selected text field, e.g. to insert or delete text. 

If you have a text field *within* your keyboard, you therefore need to find a way to route text to that text field instead of the active application.  

KeyboardKit adds ways to make text routing easier. ``KeyboardInputViewController`` has a custom ``KeyboardInputViewController/textInputProxy`` that can be set to route text to any other text field.

[KeyboardKit Pro][Pro] unlocks even more routing utils, like a **KeyboardTextField** that automatically register and resign as the main text input proxy.



## How to route text with KeyboardKit

**UIInputController** has a **textDocumentProxy**, which is how a keyboard extension by default interacts with the currently active application.

To make text routing easy, ``KeyboardInputViewController`` has a ``KeyboardInputViewController/textInputProxy`` that can be set to override ``KeyboardInputViewController/textDocumentProxy`` as the main text document proxy.

Setting ``KeyboardInputViewController/textInputProxy`` to a custom proxy will cause any text you type with the keyboard to be sent to that proxy instead of the original proxy. 

Just set ``KeyboardInputViewController/textInputProxy`` to **nil** to restore the original proxy and start routing text back to the main application. 

You can always access the original proxy with ``KeyboardInputViewController/originalTextDocumentProxy``.  



## 👑 Pro features

KeyboardKit Pro unlocks text input components that automatically register and unregister themselves as the main text input proxy when they receive and lose focus:

* **KeyboardTextField** wraps a **UITextField** and can be used for single-line text inputs.
* **KeyboardTextView** wraps a **UITextView** and can be used for multi-line text inputs.

Both views also support SwiftUI **FocusState** and have a **focused** view modifier that lets you provide a custom done button that slides in when the view is focused.

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

> Important: Due to an iOS bug, text inputs in a keyboard extension will crash if Full Access is disabled. To avoid this, this view is automatically disabled if Full Access is disabled.




[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

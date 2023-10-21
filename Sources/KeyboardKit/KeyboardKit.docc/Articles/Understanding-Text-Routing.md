# Understanding Text Routing

This article describes the KeyboardKit text routing engine.

iOS keyboard extensions use the native **UITextDocumentProxy** to integrate with the currently active application. However, if you have a text field *in* your keyboard, you need to find a way to route the text to that text field instead of the active application.  

KeyboardKit adds ways to make text routing easier. ``KeyboardInputViewController`` has a custom ``KeyboardInputViewController/textInputProxy`` that can be set to route text from the original text document proxy to any other text field.

[KeyboardKit Pro][Pro] unlocks even more capabilities, such as a text field and a text view that automatically register and resign as the main text document proxy. Information about Pro features can be found at the end of this article.



## How does text routing work?

`UIInputController` has a `textDocumentProxy`, which is how a keyboard is meant to integrate with the currently active app. 

However, there may come a time when you have to type into a text field *inside* the keyboard instead of sending the text to the main app, for instance to implement in-keyboard search. 

For this to work, you need a way to route the text so it stays within your keyboard, instead of being sent to the main app. KeyboardKit makes this kind of text routing easy to implement.



## How to route text with KeyboardKit

KeyboardKit has a ``TextInputProxy`` that can be used to route text to a custom text input. ``KeyboardInputViewController`` then has a ``KeyboardInputViewController/textInputProxy`` that can be set to replace ``KeyboardInputViewController/textDocumentProxy`` as the main text document proxy.

Setting ``KeyboardInputViewController/textInputProxy`` to a custom proxy will cause any text you type into the keyboard to be sent to that proxy instead of the original proxy. Just set the custom proxy to `nil` to restore the original proxy and start routing text back to the main application.  

You can always access the original text document proxy with ``KeyboardInputViewController/mainTextDocumentProxy``.



## 👑 Pro features

KeyboardKit Pro unlocks text input components that automatically register and unregister themselves as the main text input proxy when they receive and lose focus:

* **KeyboardTextField** wraps a **UITextField** and can be used for single-line text inputs.
* **KeyboardTextView** wraps a **UITextView** and can be used for multi-line text inputs.

Both views also support SwiftUI **FocusState** and have a **focused** view modifier that lets you provide a custom done button that slides in when the view is focused.

You can also let any **UIResponder & UITextInput** implement the **KeyboardInputComponent** protocol, then call its functions to make it register and unregister as the main text document proxy.

You can also let any SwiftUI view implement the **KeyboardInputView** protocol to apply a focused state, together with a done button that appears when the text field has focus.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

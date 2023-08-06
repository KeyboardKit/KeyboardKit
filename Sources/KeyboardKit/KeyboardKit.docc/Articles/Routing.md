# Routing

This article describes the KeyboardKit text routing engine.


KeyboardKit adds ways for you to route typed text to other parts of the keyboard.



## How does text routing work?

`UIInputController` has a `textDocumentProxy`, which is how a keyboard extensions is meant to integrate with the currently active app. 

However, there may come a time when you have to type into a text field *inside* the keyboard instead of sending the text to the main app, for instance to implement in-keyboard search. 

For this to work, you need a way to route the text so it stays within your keyboard instead of being sent to the main app. KeyboardKit makes this kind of text routing easy to implement.



## How to route text with KeyboardKit

To route text to a text field within the keyboard, KeyboardKit has a ``TextInputProxy`` that can be used to route text to any custom ``TextInputProxy/TextInput``. 

``KeyboardInputViewController`` then has a ``KeyboardInputViewController/textInputProxy``, that when set causes ``KeyboardInputViewController/textDocumentProxy`` to return it instead of the standard text document proxy.

You can always access the standard text document proxy with ``KeyboardInputViewController/mainTextDocumentProxy``, even when a custom proxy has been set.



## Auto-routing text input views

To make routing even easier, KeyboardKit has text input views that automatically register and unregister themselves as the text input proxy when they receive and lose focus.

* ``KeyboardTextField`` wraps a `UITextField` and can be used for single-line text inputs.
* ``KeyboardTextView`` wraps a `UITextView` and can be used for multi-line text inputs.

Both views also support SwiftUI `FocusState` and have a `focused` view modifier that lets you provide a custom done button that slides in when the view is focused.

 

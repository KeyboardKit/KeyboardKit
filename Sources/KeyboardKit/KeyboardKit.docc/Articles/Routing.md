# Routing

This article describes the KeyboardKit text routing engine.


KeyboardKit adds ways for you to route typed text to other parts of the keyboard.


## How does text routing work?

In general, all `UIInputController`s have a `textDocumentProxy`, which is how a keyboard estensions integrates with the currently active app. It lets you insert and remove text, move the cursor forward and backward etc.

However, there may come a time when you have to type into a text field *inside* the keyboard itself, for instance to implement in-keyboard search, settings etc. 

For this to work, you need a way to route the text so it ends up in your keyboard's text field instead of in the main app.

KeyboardKit provides you with a set of tools to route text within the keyboard.



## How to route text with KeyboardKit

To make it easier to route the typed text to a text field within the keyboard, KeyboardKit has a ``TextInputProxy`` that implements `UITextDocumentProxy` and can be used to route text to any custom ``TextInputProxy/TextInput``. 

``KeyboardInputViewController`` then has a ``KeyboardInputViewController/textInputProxy`` property that, whenever set, will cause ``KeyboardInputViewController/textDocumentProxy`` to return it instead of the standard text document proxy.

You can always access the standard text document proxy with ``KeyboardInputViewController/mainTextDocumentProxy``, even when a custom proxy has been set. 



## How to add auto-routing text fields to a keyboard

To make it even easier to route text within a keyboard extension, KeyboardKit provides you with text input views, that will automatically register and unregister themselves as the current text input proxy when they receive and lose focus.

* ``KeyboardTextField`` wraps a native `UITextField` and can be used for single-line text inputs.
* ``KeyboardTextView`` wraps a native `UITextView` and can be used for multi-line text inputs.

Both views accept a configuration block that can be used to customize the native `UIKit` views.

Both views also support SwiftUI `FocusState` and have a `focused` view modifier that lets you provide a custom done button that slides in when the view is focused.  

The demo app has a keyboard that lets you play around with these text input views.

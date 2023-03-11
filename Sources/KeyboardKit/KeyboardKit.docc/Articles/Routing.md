# Routing

This article describes how KeyboardKit adds ways for you to route text from the main app to other text fields within the keyboard.

In general, all `UIInputController`s have a `textDocumentProxy`, which is the way that a keyboard estensions integrates with the currently active app. It lets you insert and remove text, move the cursor forward and backward etc. and KeyboardKit provides a bunch of additional extensions and utilities to make the proxy even more capable than it is with the native APIs. 

However, there may come a time when you have to type into a text field *inside* the keyboard itself, for instance to implement in-keyboard search, text input settings etc. For this to work, you need a way to route the text to so that the text ends up in your keyboard's text field instead of in the main app.

Since implementing your own custom proxy implementation is a pretty complicated task, KeyboardKit provides you with a set of tools that make text routing trivial.



## How to route text with KeyboardKit

To make it easier to route text from the main app to any custom input, KeyboardKit has a ``TextInputProxy`` that implements `UITextDocumentProxy` and can be used to redirect text to any custom ``TextInputProxy/TextInput``. ``KeyboardInputViewController`` then has a ``KeyboardInputViewController/textInputProxy`` property that, whenever set, will take over as the ``KeyboardInputViewController/mainTextDocumentProxy`` from the default ``KeyboardInputViewController/textDocumentProxy``.

To make it even easier to route text within a keyboard extension, KeyboardKit provides you with two already implemented text input views, that will automatically register themselves as custom proxy destinations when they receive focus and unregister themselves when they lose focus.

* ``KeyboardTextField`` wraps a native `UITextField` and can be used for single-line text inputs.
* ``KeyboardTextView`` wraps a native `UITextView` and can be used for multi-line text inputs.

Both views accept a configuration action that can be used to customize the native `UIKit` views. Furthermore, ``KeyboardTextField`` can be configured to automatically resign as the first responder when the user taps return (or any primary button that inserts a newline).

Both views support native SwiftUI `FocusState`, and have a `focused` view modifier that lets you provide a custom done button that slides in when the view is focused, and can be tapped to make the view resign as the first responder and return focus to the main app.  

The demo app has a keyboard that lets you play around with these text input views.

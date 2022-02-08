# Proxy

KeyboardKit defines a bunch of extensions to `UITextDocumentProxy` and ways to route text to other sources.


## UITextDocumentProxy Extensions

KeyboardKit extends the limited `UITextDocumentProxy` functionality with more features. These are currently undocumented, but can be found in various `UITextDocumentProxy` source code extension files.


## Text Input Proxy

KeyboardKit has a `TextInputProxy` class that can be used to implement custom text document proxies. This makes it possible to add text fields to the keyboard extension and redirect typing from the main app to the text field.

You can redirect the keyboard by setting the input controller's `textInputProxy` to a custom proxy. The `KeyboardTextField` and `KeyboardTextView` views does this automatically, so either use them or look to them for inspiration.

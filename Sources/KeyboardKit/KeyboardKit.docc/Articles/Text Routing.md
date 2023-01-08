# Text Routing

This article describes how KeyboardKit adds ways for you to route text to other text fields within the keyboard.

Keyboard input view controllers have a `textDocumentProxy`, which is the way a keyboard integrates with the currently active app. It lets you insert and remove text, move the cursor forward and backward etc.

However, sometimes you have to add a text field *inside* the keyboard itself, for instance to provide search, settings etc. For this to work, you need to route text to text field instead of the standard proxy, so that the text ends up in your text field instead of the main app.



## How to route text to text fields in the keyboard

KeyboardKit has a ``TextInputProxy`` that can be used to create custom text proxies and redirect the typed text to a custom text field within the keyboard. One example could be to add a search field to a toolbar within the keyboard.

You can redirect the typed text by setting the input controller's ``KeyboardInputViewController/textInputProxy`` property to a custom proxy. The ``KeyboardTextField`` and ``KeyboardTextView`` views do this automatically, so you can either use them or look to them for inspiration.

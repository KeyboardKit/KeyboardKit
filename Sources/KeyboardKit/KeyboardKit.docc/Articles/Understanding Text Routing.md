# Understanding Text Routing

This article describes how KeyboardKit adds ways for you to route text to other text fields within the keyboard.


## Overview

iOS keyboard extensions provide their input view controller with a `textDocumentProxy`, which is the way the keyboard is intended to work with the current text document. It let's you insert text, move the cursor forward and backward, delete backwards etc.

However, sometimes you may want to add a text field *inside* the keyboard itself, for instance to provide search functionality if your keyboard has a bunch of features.

For this to work, you need to route text to another destination than the standard text document proxy, so that the text ends up in your custom text field instead of being sent to the main app.



## How to route text to text fields in the keyboard

KeyboardKit has a ``TextInputProxy`` class that can be used to create custom text proxies and redirect the typed text from the main app to a custom text field within the keyboard. One example could be to add a search field to a toolbar within the keyboard.

You can redirect the typed text by setting the input controller's ``KeyboardInputViewController/textInputProxy`` property to a custom proxy. The ``KeyboardTextField`` and ``KeyboardTextView`` views does this automatically, so you can either use them or look to them for inspiration.

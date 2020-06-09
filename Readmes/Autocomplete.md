# Autocomplete

KeyboardKit provides autocomplete support, which means that your keyboard can display autocomplete suggestions that replace the current word when a user taps a suggestion. 

You have to implement your own autocomplete provider and use it to provide the keyboard with suggestions. Have a look at the demo app for examples.

**IMPORTANT** `textWillChange` and `textDidChange` are not called when a user types and text is sent to the text document proxy. This means that you must also request autocomplete suggestions whenever the user interacts with the keyboard. Have a look at the demo.

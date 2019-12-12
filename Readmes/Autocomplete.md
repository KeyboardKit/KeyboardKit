# Autocomplete

KeyboardKit supports autocomplete, which means that you can add a toolbar that displays autocomplete suggestions for the currently typed text and replaces text in your text document proxy when you tap a  suggestion.

You have to implement your own autocomplete provider and use it to provide the keyboard with suggestions. Have a look at the demo app for examples on how to implement this.

**IMPORTANT** `textWillChange` and `textDidChange` are not called when a user types and text is sent to the text document proxy. This means that you must also request autocomplete suggestions whenever the user interacts with the keyboard. Have a look at the demo.

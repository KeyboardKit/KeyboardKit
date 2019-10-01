# Autocomplete

KeyboardKit supports autocomplete, which means that you can add a toolbar that displays autocomplete suggestions for the currently typed text and replaces text in your text document proxy when you tap a  suggestion.

You have to implement your own autocomplete provider and use it to provide the keyboard with suggestions. Have a look at the demo app for examples on how to implement this.

**IMPORTANT** iOS has a bug that causes `textWillChange` and `textDidChange` to not be called when a user types and text is sent to the text document proxy. This makes autocomplete impossible, since the text document proxy information is not updated when the user types. To solve this, you can create an `AutocompleteBugFixTimer`, which solves the problem by moving the text cursor, forcing these functions to be called. However, it's a nasty hack with side-effects, so use it with caution.
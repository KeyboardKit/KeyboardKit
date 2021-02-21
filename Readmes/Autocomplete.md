# Autocomplete

KeyboardKit comes with built-in components for implementing audiocomplete.


## Triggers

`KeyboardInputViewController` has two functions that you can override to handle autocomplete:

* `performAutocomplete` is automatically triggered whenever new suggestions are needed.
* `resetAutocomplete` is automatically triggered whenever existing suggestions should be cleared.

You can override these functions to inject your custom autocomplete logic. KeyboardKit currently has no built-in support for this.


## Autocomplete suggestion providers

KeyboardKit has a `AutocompleteSuggestionProvider` protocol that can be implemented by any class that can be used to provide autocomplete suggestions as the user types.

`KeyboardInputViewController` will automatically create an `AutocompleteContext` and bind it to its `autocompleteContext` property when the extension is started. You can use it as is or replace it with a custom one.

`KeyboardInputViewController` will however *not* create a standard provider, since there is currently no built-in provider in the library.

Note that the existing autocomplete protocols and contexts are really basic. If your keyboard is meant to provide a kick-ass autocomplete feature, I'd suggest using the existing tools as inspiration and build your own.


## Demo

The demo application has a *fake* autocomplete feature that demonstrates how to implement autocomplete. It will just autocomplete the current word with different suffixes. 

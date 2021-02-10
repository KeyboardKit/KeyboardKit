# Autocomplete

KeyboardKit comes with built-in components for implementing audiocomplete.


## Triggers

`KeyboardInputViewController` has two functions that you can override to handle autocomplete:

* `performAutocomplete` is automatically triggered whenever new suggestions are needed.
* `resetAutocomplete` is automatically triggered whenever existing suggestions should be cleared.

You can override these functions to inject your custom autocomplete logic. KeyboardKit currently has no built-in support for this.


## Autocomplete suggestion providers

KeyboardKit has a `AutocompleteSuggestionProvider` protocol that can be implemented by any class that can be used to provide suggestions for any text, such as the currently typed word.

`KeyboardInputViewController` will not create a standard provider when the extension is started, since there is currently no built-in provider in the library.

However, it will create an `ObservableAutocompleteContext` and inject it into the view hierarchy. You can update this and use it by your own views to control which suggestions to show.


## Demo application

The demo application has a fake autocomplete feature that demonstrates how to implement autocomplete.

Note that the existing autocomplete protocols and contexts are really basic. If your keyboard is meant to provide a kick-ass autocomplete feature, I'd suggest using the existing tools as inspiration and build your own. 

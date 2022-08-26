# Autocomplete

KeyboardKit can present autocomplete suggestions as users type, using an `AutocompleteProvider`.
 
The core library doesn't come with an autocomplete engine, but you can implement and inject your own or use [KeyboardKit Pro][Pro], which adds a local and remote autocomplete engines that provides localized suggestions.


## How does autocomplete work?

KeyboardKit has an `AutocompleteProvider` protocol that can be implemented by classes that can provide autocomplete suggestions, as well as an observable `AutocompleteContext` class that can be used to update and inspect the current autocomplete state.

`KeyboardInputViewController` will setup an `autocompleteProvider` and an `autocompleteContext` when the keyboard is started, then has two functions that you can override to handle autocomplete:

* `performAutocomplete` is triggered when new suggestions are needed.
* `resetAutocomplete` is triggered when existing suggestions should be cleared.

You can override these functions to inject your custom autocomplete logic.


## KeyboardKit Pro

KeyboardKit Pro defines a few different autocomplete providers, which can be used to provide autocomplete suggestions.

* `StandardAutocompleteProvider` is injected by default when a Pro license is registered. It uses the provided `locale` to provide localized, non-predictable suggestions. 
* `ExternalAutocompleteProvider` is a base class that you can subclass to implement a provided that fetches suggestions from a remote endpoint. This requires full access and that the user is connected to the Internet.

You can try out the standard autocomplete provider in the Pro-specific demo app.


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on autocomplete.



[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/

# Autocomplete

KeyboardKit can present autocomplete suggestions as users type. 

The core library doesn't come with an implemented engine, but you can implement and inject your own. 

[KeyboardKit Pro][Pro] adds a localized autocomplete engine that provides localized suggestions.


## Autocomplete provider

KeyboardKit has a `AutocompleteProvider` protocol that can be implemented by any class that can be used to provide autocomplete suggestions.

`KeyboardInputViewController` will automatically create a `DisabledAutocompleteProvider` and bind it to its `autocompleteProvider` property when the extension is started. You can replace it with a custom provider.


## Autocomplete context

`KeyboardInputViewController` will automatically create an `AutocompleteContext` and bind it to its `autocompleteContext` property when the extension is started.

The context contains observable properties that informs you about the current autocomplete state.


## Autocomplete triggers

`KeyboardInputViewController` has two functions that you can override to handle autocomplete:

* `performAutocomplete` is triggered when new suggestions are needed.
* `resetAutocomplete` is triggered when existing suggestions should be cleared.

You can override these functions to inject your custom autocomplete logic.


## KeyboardKit Pro

KeyboardKit Pro defines a few different autocomplete providers, which can be used to provide autocomplete suggestions.

The `StandardAutocompleteProvider` is injected by default when a Pro license is registered. It uses the provided `locale` to provide localized suggestions. It is however not predictable and will only complete the current word. 

The `ExternalAutocompleteProvider` is a base class that you can subclass to implement a provided that fetches suggestions from a remote endpoint. This provided requires full access, but can let you provide very powerful autocomplete logic as long as the user is connected to the Internet.

[Read more here][Pro]. 


## Demo

The demo application has a *fake* autocomplete provider that demonstrates how to implement autocomplete. 

The fake provider will just autocomplete the current word with different suffixes.

The demo also registers a KeyboardKit Pro license, to demonstrate how the standard provider behaves. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

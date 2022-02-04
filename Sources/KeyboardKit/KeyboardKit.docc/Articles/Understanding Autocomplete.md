# Understanding Autocomplete

This article describes how autocomple works in KeyboardKit. 


# Setting up autocomplete

KeyboardKit has an ``AutocompleteProvider`` protocol that describes how autocomplete works. ``AutocompleteProvider/autocompleteSuggestions(for:completion:)`` is for instance used to retrieve defines if the action handler can handle a certain gesture on a certain action and ``AutocompleteProvider/handle(_:on:)`` handles a certain gestesture on a certain action.

KeyboardKit sets up a ``StandardAutocompleteProvider`` instance by default when a ``KeyboardInputViewController`` is initalized. The library will use this instance by default when handling actions.

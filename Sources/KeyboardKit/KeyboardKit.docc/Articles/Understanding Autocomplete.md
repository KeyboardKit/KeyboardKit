# Understanding Autocomplete

This article describes the KeyboardKit autocomplete model and how to use it. 


## Autocomplete provider

KeyboardKit has a ``AutocompleteProvider`` protocol that that can be used to give autocomplete suggestions as the user types.

KeyboardKit doesn't have an autocomplete provider as it has for most other services, just an internal disabled one that it uses as a placeholder until you inject your own provider or use KeyboardKit Pro.

KeyboardKit Pro unlocks two autocomplete providers when you register a valid license. The `StandardAutocompleteProvider` is locale-specific and non-predictive, and is injected when you register a license. `ExternalAutocompleteProvider` is a base class that can be inherited to communicate with an api.


## How to create a custom provider

If you don't have a Pro license, you can implement a custom autocomplete provider in any way you like. When you're done, just replace the controller service with the implementation to make the library use it instead. 

For instance, here is a custom autocomplete provider that just adds a suffix to the provided text:


```swift
class MyAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current

    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        if text.isEmpty { return completion(.success([])) }
        completion(.success(suggestions(for: text)))
    }
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
}

private extension FakeAutocompleteProvider {
    
    func suggestions(for text: String) -> [AutocompleteSuggestion] {
        [
            suggestion(text + "ly"),
            suggestion(text + "er", "Subtitle"),
            suggestion(text + "ter")
        ]
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        StandardAutocompleteSuggestion(
            text: word, 
            title: word, 
            subtitle: subtitle)
    }
}

```

To use this implementation instead of the standard one, just replace the standard instance like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        autocompleteProvider = MyAutocompleteProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.


## How to perform autocomplete

``KeyboardInputViewController`` has a ``KeyboardInputViewController/performAutocomplete()`` function that you can call at any time to perform an autocomplete operation for the typed text. 

A successful autocomplete operation will update the controller's ``AutocompleteContext``. You can use its ``AutocompleteContext/suggestions`` in any way you like or use the ``AutocompleteToolbar`` to display and apply autocomplete suggestions automatically.

If you ever need to reset the current autocomplete state, you can call ``KeyboardInputViewController/resetAutocomplete()`` to reset any existing suggestions.

The controller has a ``KeyboardInputViewController/autocompleteText`` property that it uses when performing autocomplete. By default, the text document proxy's current word will be used, but you can override ``KeyboardInputViewController/autocompleteText`` and customize this in any way you want. 

You can override ``KeyboardInputViewController/performAutocomplete()`` and ``KeyboardInputViewController/resetAutocomplete()`` as well, to customize the default autocomplete behavior. 

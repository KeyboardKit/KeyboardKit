# Understanding Autocomplete

This article describes the KeyboardKit autocomplete model and how to use it. 


## Autocomplete provider

KeyboardKit has a ``AutocompleteProvider`` protocol that that describes how to provide a keyboard with autocomplete suggestions as the user types.

KeyboardKit doesn't have an autocomplete provider as it has for most other services, just an internal disabled one that it uses as a placeholder until you inject your own provider or use KeyboardKit Pro.

KeyboardKit Pro unlocks two autocomplete providers when you register a valid license. The `StandardAutocompleteProvider` is local and locale-specific, while `ExternalAutocompleteProvider` can be inherited to implement an autocomplete provider that communicates with an external api.


## How to create a custom provider

If you don't have a Pro license, you can implement a custom autocomplete provider. 

You can create a custom autocomplete provider by implementing the ``AutocompleteProvider`` protocol.

For instance, here is an implementation that just adds a suffix to the provided text's current word:


```swift
class MyAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current

    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        let word = text.split(by: String.wordDelimiters).last ?? ""
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

A successful autocomplete operation will update the controller's ``AutocompleteContext`` instance, after which the ``AutocompleteContext/suggestions`` can be used in any way you like.

One way to use an autocomple result, is to pass its suggestions to an ``AutocompleteToolbar``, which will display and apply autocomplete suggestions automatically.

If you ever need to reset the current autocomplete state, you can call ``KeyboardInputViewController/resetAutocomplete()`` to reset any existing suggestions.

The controller has a ``KeyboardInputViewController/autocompleteText`` property that it uses when performing autocomplete. By default, the text document proxy's text before the input cursor will be used, but you can override it to customize the behavior in any way you want. 

You can override ``KeyboardInputViewController/performAutocomplete()`` and ``KeyboardInputViewController/resetAutocomplete()`` as well, to customize the default autocomplete behavior. 

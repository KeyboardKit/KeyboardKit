# Understanding Autocomplete

This article describes the KeyboardKit autocomplete engine and how to use it.


## Autocomplete provider

In KeyboardKit, autocomplete providers can be used to provide the keyboard with autocomplete suggestions as the user types.

Autocomplete can be performed with an ``AutocompleteProvider``, which is a protocol that describes how to provide autocomplete suggestions to a keyboard extension.

KeyboardKit doesn't have an autocomplete provider as it has for most other services. Instead, you can create your own custom provider or use [KeyboardKit Pro][Pro]. 



## KeyboardKit Pro autocomplete providers

[KeyboardKit Pro][Pro] unlocks two autocomplete providers when you register a valid license.

`StandardAutocompleteProvider` is a locale-specific provider that uses on-device capabilities to implement autocomplete and basic word prediction.

`ExternalAutocompleteProvider` can be inherited to implement autocomplete providers that communicate with external api:s.



## How to create a custom provider

You can implement a custom autocomplete provider if you want to provide your keyboard with custom autocomplete suggestions, for instance from an embedded framework, an external api etc.

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

private extension MyAutocompleteProvider {
    
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

To use this provider instead of the standard one, just set the input controller's ``KeyboardInputViewController/autocompleteProvider`` like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        autocompleteProvider = MyAutocompleteProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## How to perform autocomplete

Autocomplete is performed automatically, since ``KeyboardInputViewController`` calls ``KeyboardInputViewController/performAutocomplete()`` when its text changes. You can call this function at any time to perform an autocomplete operation for the currently typed text. 

A successful autocomplete operation will update the controller's ``KeyboardInputViewController/autocompleteContext``, after which its ``AutocompleteContext/suggestions`` can be used in any way you like, for instance by passing them into an ``AutocompleteToolbar``.

If you ever need to reset the current autocomplete state, you can call ``KeyboardInputViewController/resetAutocomplete()`` to reset any existing suggestions.

The controller has a ``KeyboardInputViewController/autocompleteText`` property that it uses when performing autocomplete. By default, the ``KeyboardInputViewController/textDocumentProxy``'s text before the input cursor will be used, but you can override it to customize this behavior. 

You can also override ``KeyboardInputViewController/performAutocomplete()`` and ``KeyboardInputViewController/resetAutocomplete()`` to customize the default autocomplete behavior. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

# Understanding Autocomplete

This article describes the KeyboardKit autocomplete engine.

Autocomplete is an important part of the typing experience, and will show suggestions as the user types and moves the input cursor.

An ``AutocompleteProvider`` can be used to provide suggestions to an ``AutocompleteContext``, which in turn will update views like the ``Autocomplete/Toolbar``. 

KeyboardKit doesn't have a standard provider as it has for other services. Instead, it binds a disabled provider to ``KeyboardInputViewController/autocompleteProvider`` until you replace it.

[KeyboardKit Pro][Pro] unlocks and registers a local autocomplete provider when you register a valid license. Information about Pro features can be found at the end of this article.



## Autocomplete namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-specic types and views, except protocols and contexts.

For instance, an ``Autocomplete/Toolbar`` can be used to show suggestions. The ``SystemKeyboard`` will add an autocomplete toolbar by default, unless you explicitly tell it not to.



## How to perform autocomplete

KeyboardKit will automatically call ``KeyboardController/performAutocomplete()`` when the text changes. This will update the ``KeyboardInputViewController/autocompleteContext`` with suggestions from the ``KeyboardInputViewController/autocompleteProvider``, which causes views like ``Autocomplete/Toolbar`` to update.

If you need to reset autocomplete state, you can call the controller's ``KeyboardController/resetAutocomplete()`` or the context's ``AutocompleteContext/reset()`` functions.



## How to customize the autocomplete behavior

You can customize the autocomplete behavior by replacing ``KeyboardInputViewController/autocompleteProvider`` with a custom ``AutocompleteProvider`` or by overriding the various ``KeyboardInputViewController`` functions.  

For instance, ``KeyboardInputViewController/autocompleteText`` determines which text to pass into the provider. It uses ``KeyboardInputViewController/textDocumentProxy`` by default, but you can override it to customize which text to use.

If you want to temporarily or permanently disable autocomplete, set the ``KeyboardInputViewController/autocompleteContext`` ``AutocompleteContext/isEnabled`` property to `false`.



## How to create a custom autocomplete provider

You can create a custom ``AutocompleteProvider`` that uses any 3rd party services, SDKs or APIs.

For instance, here's a custom provider that just adds a suffix to the provided text's current word:

```swift
class FakeAutocompleteProvider: AutocompleteProvider {

    init(match: String = "match") {
        self.match = match
    }

    private var match: String
    
    var locale: Locale = .current
    
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
    
    func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion] {
        guard text.count > 0 else { return [] }
        if text == match {
            return matchSuggestions()
        } else {
            return fakeSuggestions(for: text)
        }
    }
}

private extension FakeAutocompleteProvider {
    
    func fakeSuggestions(for text: String) -> [Autocomplete.Suggestion] {
        [
            .init(text: text + "-1"),
            .init(text: text + "-2", subtitle: "Subtitle"),
            .init(text: text + "-3")
        ]
    }
    
    func fakeSuggestion(_ text: String, _ subtitle: String? = nil) -> Autocomplete.Suggestion {
        .init(text: text, subtitle: subtitle)
    }

    func matchSuggestions() -> [Autocomplete.Suggestion] {
        [
            .init(text: match, isUnknown: true),
            .init(text: match, isAutocorrect: true),
            .init(text: match),
        ]
    }
}
```

To use this provider instead of the standard one, just set ``KeyboardInputViewController/autocompleteProvider`` to this custom provider:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        autocompleteProvider = CustomAutocompleteProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.   



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional autocomplete providers and utilities.


### Local autocomplete provider

KeyboardKit Pro unlocks and sets up a LocalAutocompleteProvider when you register a valid license. You can inherit and customize it to modify its default behavior.

This provider uses on-device capabilities to perform autocomplete. It works offline, doesn't require full access and integrates with other system components, like the on-device lexicon. It currently doesn't provide next word prediction. 


### Remote autocomplete provider

KeyboardKit Pro unlocks a RemoteAutocompleteProvider, which can be integrated with external REST-based APIs. 

Since most autocomplete APIs require a token or some form of authentication, the demo app doesn't show this provider in action.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

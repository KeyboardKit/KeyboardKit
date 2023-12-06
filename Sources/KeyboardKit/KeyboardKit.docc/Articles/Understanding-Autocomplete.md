# Understanding Autocomplete

This article describes the KeyboardKit autocomplete engine.

Autocomplete is an important part of the typing experience, where autocomplete suggestions are shown as the current text changes.

In KeyboardKit, an ``AutocompleteProvider`` can be used to provide suggestions, which in turn can be presented in views like an ``AutocompleteToolbar``.

KeyboardKit doesn't have a standard provider as it has for other services. Instead, it binds a disabled provider to ``KeyboardInputViewController/services`` until you replace it with a custom provider or activate KeyboardKit Pro.

[KeyboardKit Pro][Pro] unlocks a local and a remote autocomplete provider. More information about Pro features can be found at the end of this article.



## Autocomplete namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types.

The namespace doesn't contain protocols, open classes, or types that are meant to be exposed at the top-level.



## Autocomplete context

KeyboardKit has an observable ``AutocompleteContext`` class that can be used to handle autocomplete state, such as whether or not autocomplete and autocorrection is enabled, which suggestions to show the user, etc.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/state``, then updates it when autocomplete is performed.



## How to perform autocomplete

KeyboardKit will automatically call ``KeyboardController/performAutocomplete()`` whenever the text changes, then update the ``KeyboardInputViewController/state`` context with suggestions from the ``KeyboardInputViewController/services`` provider.

You can use the suggestions in any way you like. Views like ``AutocompleteToolbar`` automatically present the latest suggestions, and handle any tapped suggestion with the main ``KeyboardActionHandler``.

You can call the context's ``AutocompleteContext/reset()`` function to reset the autocomplete state, and use ``AutocompleteContext/isAutocompleteEnabled`` to disable autocomplete altogether, or ``AutocompleteContext/isAutocorrectEnabled`` to just disable autocorrection.



## How to customize the autocomplete behavior

You can customize the autocomplete behavior by replacing the ``KeyboardInputViewController/services`` provider with a custom ``AutocompleteProvider`` or by overriding the various ``KeyboardInputViewController`` functions.

For instance, the ``KeyboardInputViewController/autocompleteText`` property determines which text to pass into the provider. It uses ``KeyboardInputViewController/textDocumentProxy`` by default, but you can override it to customize which text to use.



## How to create a custom autocomplete provider

You can replace the ``KeyboardInputViewController/services`` autocomplete provider with a custom provider, for instance to integrate with a custom SDK or 3rd party provider.

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
            .init(text: text, isUnknown: true),
            .init(text: text, isAutocorrect: true),
            .init(text: text, subtitle: "Subtitle")
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

To use this provider instead of the standard one, just set the ``KeyboardInputViewController/services`` provider to this custom provider:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.autocompleteProvider = CustomAutocompleteProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.   



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional autocomplete providers and binds a **LocalAutocompleteProvider** instance to ``KeyboardInputViewController/services``.

### LocalAutocompleteProvider

This provider performs autocomplete on device. It works offline, doesn't require full access and integrates with other system services, like the local lexicon. It currently doesn't provide next word prediction. 

### RemoteAutocompleteProvider

This provider can be used to integrate with external REST-based APIs and web services. It requires that the device is online and that Full Access is enabled, otherwise it won't be able to communicate with the remote endpoint.

### How to customize these providers 

You can inherit and customize these provider to modify their default behavior.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

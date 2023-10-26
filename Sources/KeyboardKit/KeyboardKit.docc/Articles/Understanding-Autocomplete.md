# Understanding Autocomplete

This article describes the KeyboardKit autocomplete engine.

Autocomplete is an important part of the typing experience, where autocomplete suggestions are shown as the current text changes.

In KeyboardKit, an ``AutocompleteProvider`` can be used to provide suggestions to an ``AutocompleteContext``, which in turn can update views like an ``AutocompleteToolbar`` automatically through state observation.

KeyboardKit doesn't have a standard provider as it has for other services. Instead, it binds a disabled provider to ``KeyboardInputViewController/services`` until you replace it with a custom provider or activate KeyboardKit Pro.

[KeyboardKit Pro][Pro] unlocks and registers local autocomplete. More information about Pro features can be found at the end of this article.



## Autocomplete namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types.

The namespace doesn't contain protocols, open classes, or types that are meant to be exposed at the top-level.



## Autocomplete context

KeyboardKit has an observable ``AutocompleteContext`` class that provides autocomplete state, such as the suggestions to present.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/state``, then updates it when autocomplete is performed.



## How to perform autocomplete

KeyboardKit will call ``KeyboardController/performAutocomplete()`` when the text changes. This will update the ``KeyboardInputViewController/state`` context with suggestions from the main ``KeyboardInputViewController/services`` provider. 

You can use these suggestions in any way you like. Views like the ``AutocompleteToolbar`` will automatically update to present the latest suggestions, and will handle any tapped suggestion with the main ``KeyboardActionHandler``.

You are of course not restricted to use an ``AutocompleteToolbar``. You can use and present these suggestions in any way you want.

If you need to reset autocomplete state, you can call the context's ``AutocompleteContext/reset()`` functions. You can also set the context's ``AutocompleteContext/isEnabled`` to false to disable autocomplete altogether.



## How to customize the autocomplete behavior

You can customize the autocomplete behavior by replacing the ``KeyboardInputViewController/services`` provider with a custom ``AutocompleteProvider`` or by overriding the various ``KeyboardInputViewController`` functions.

For instance, the ``KeyboardInputViewController/autocompleteText`` property determines which text to pass into the provider. It uses ``KeyboardInputViewController/textDocumentProxy`` by default, but you can override it to customize which text to use.

If you want to temporarily or permanently disable autocomplete, just can also set the context's ``AutocompleteContext/isEnabled`` to `false`.



## How to create a custom autocomplete provider

You can replace the ``KeyboardInputViewController/services`` autocomplete provider with a custom provider, for instance if you want to integrate with a custom SDK or 3rd party provider.

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

This provider uses on-device capabilities to perform autocomplete. It works offline, doesn't require full access and integrates with other system components, like the on-device lexicon. It currently doesn't provide next word prediction. 

You can inherit and customize this provider to modify its default behavior.

### RemoteAutocompleteProvider

This provider can be used to integrate with external REST-based APIs and web services. All you have to do is to specify endpoints and various parameters, as well as a model that matches the service response.

Since most autocomplete APIs require a token or some form of authentication, the demo app doesn't show this provider in action.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

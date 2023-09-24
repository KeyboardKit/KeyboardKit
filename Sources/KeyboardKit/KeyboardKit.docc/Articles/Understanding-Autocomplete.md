# Understanding Autocomplete

This article describes the KeyboardKit autocomplete engine.

Autocomplete is an important part of the typing experience, and will show suggestions as the user types and moves the input cursor.

In KeyboardKit, an ``AutocompleteProvider`` can be used to provide suggestions to an ``AutocompleteContext``, which in turn can update views like an ``AutocompleteToolbar``. 

KeyboardKit doesn't have a standard provider as it has for other services. Instead, it binds a disabled autocomplete provider to the main ``KeyboardInputViewController/autocompleteProvider`` until you replace it or register a KeyboardKit Pro license key.

[KeyboardKit Pro][Pro] unlocks and registers a local autocomplete provider when you register a valid license key. More information about Pro features can be found at the end of this article.



## Autocomplete namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types.

The namespace doesn't contain protocols or open classes, or types that are meant to be top-level ones. It's meant to be a container for types used by top-level types, to make the library easier to overview.



## How to perform autocomplete

KeyboardKit will automatically call ``KeyboardController/performAutocomplete()`` when the text changes. This will update the main ``KeyboardInputViewController/autocompleteContext`` with suggestions from the main ``KeyboardInputViewController/autocompleteProvider``. You can use these suggestions in any way you like.

If you need to reset autocomplete state, you can call the controller's ``KeyboardController/resetAutocomplete()`` or the context's ``AutocompleteContext/reset()`` functions. You can also set the context's ``AutocompleteContext/isEnabled`` to false to disable autocomplete altogether.



## How to present autocomplete suggestions

You can use an ``AutocompleteToolbar`` to present autocomplete suggestions just like a native keyboard does. The toolbar supports custom styling and custom view and separator builders, and is highly configurable.

You are however not bound to use such a toolbar, and can of course use the suggestions in any way you want. 

> Important: Just keep in mind that it's a good idea to have around **50** points padding above the keyboard, since input and action callouts may otherwise be cut off. This padding must increase if you style the callouts to be bigger. 



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

[KeyboardKit Pro][Pro] unlocks additional autocomplete providers when you register a valid license key, then binds a LocalAutocompleteProvider to ``KeyboardInputViewController/autocompleteProvider``.

### Local autocomplete provider

This provider uses on-device capabilities to perform autocomplete. It works offline, doesn't require full access and integrates with other system components, like the on-device lexicon. It currently doesn't provide next word prediction. 

You can inherit and customize this provider to modify its default behavior.

### Remote autocomplete provider

This provider can be used to integrate with external REST-based APIs and web services. All you have to do is to specify endpoints and various parameters, as well as a model that matches the service response.

Since most autocomplete APIs require a token or some form of authentication, the demo app doesn't show this provider in action.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

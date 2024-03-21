# Autocomplete

This article describes the KeyboardKit autocomplete engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

Autocomplete is an important part of the typing experience, where suggestions are shown as the user types.

In KeyboardKit, an ``AutocompleteProvider`` can provide suggestions that can be listed in views like an autocomplete ``Autocomplete/Toolbar``.

KeyboardKit doesn't have a standard autocomplete provider implementation. Instead, it injects a disabled provider into ``KeyboardInputViewController/services`` until you replace it with a custom provider or activate KeyboardKit Pro.

👑 [KeyboardKit Pro][Pro] unlocks local and remote autocomplete. More information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Autocomplete namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types, models and views.

This namespace doesn't contain protocols, open classes or types of higher importance.



## Autocomplete context

KeyboardKit has an observable ``AutocompleteContext`` that can handle autocomplete state, such as if autocomplete is enabled, which suggestions to present, etc.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever autocomplete is performed.



## How to perform autocomplete

KeyboardKit will automatically call the controller's ``KeyboardController/performAutocomplete()`` function whenever the text changes, then update the ``KeyboardInputViewController/state`` context with suggestions from the provider in ``KeyboardInputViewController/services``.

Views like the autocomplete ``Autocomplete/Toolbar`` can list these suggestions and handle suggestion with the main ``KeyboardActionHandler``.



## How to disable autocomplete and autocorrect

Set the ``AutocompleteContext`` ``AutocompleteContext/isAutocorrectEnabled`` to **false** to disable autocorrection, and set ``AutocompleteContext/isAutocompleteEnabled`` to **false** to disable autocomplete altogether.

You can also disable autocorrection by applying an **.autocorrectionDisabled()** view modifier to the view hierarchy.



## How to customize the autocomplete behavior

You can customize the autocomplete behavior by replacing the ``KeyboardInputViewController/services`` provider with a custom ``AutocompleteProvider``. You can also customize the ``KeyboardInputViewController`` to change its autocomplete behavior.

For instance, the ``KeyboardInputViewController/autocompleteText`` property determines which text to use for autocomplete. It uses ``KeyboardInputViewController/textDocumentProxy`` by default, but you can override it to customize which text to use.



## How to create a custom autocomplete provider

You can create a custom autocomplete provider to customize the autocomplete behavior, for instance to integrate with 3rd party tools. You can implement ``AutocompleteProvider`` from scratch, or inherit and customize any [KeyboardKit Pro][Pro] provider. 

For instance, here's a custom provider that just adds a suffix to the provided text's current word:

```swift
class CustomAutocompleteProvider: AutocompleteProvider {

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

private extension CustomAutocompleteProvider {
    
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

To use this handler instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## Views

@TabNavigator {
    
    @Tab("Toolbar") {
        
        KeyboardKit has an Autocomplete.``Autocomplete/Toolbar`` that mimics a native autocomplete toolbar.
        
        ![AutocompleteToolbar](autocompletetoolbar.jpg)
            
        The view can be styled with a ``Autocomplete/ToolbarStyle``, which can be applied with the ``SwiftUI/View/autocompleteToolbarStyle(_:)`` view modifier:
        
        ```swift
        Autocomplete.Toolbar {
            ...
        }
        .autocompleteToolbarStyle(...)
        ```
    }
        
    @Tab("Items & Separators") {
        
        The ``Autocomplete`` namespace has ``Autocomplete/ToolbarItem`` & ``Autocomplete/ToolbarSeparator`` views, that are used by the toolbar. They can be styled with ``SwiftUI/View/autocompleteToolbarItemStyle(_:)`` & ``SwiftUI/View/autocompleteToolbarSeparatorStyle(_:)`` when used separately.
    }
}

See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.


## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional autocomplete providers and injects a **LocalAutocompleteProvider** into ``KeyboardInputViewController/services`` when you register a license key. These providers are open to inheritance, so you can inherit and customize them to fir your needs.

### LocalAutocompleteProvider

The **LocalAutocompleteProvider** implementation performs autocomplete on-device. It works offline, doesn't require Full Access and integrates with other system services, like the local lexicon.

> Important: This provider currently doesn't provide next word prediction, since Apple removed these capabilities in iOS 16. 

### RemoteAutocompleteProvider

The **RemoteAutocompleteProvider** implementation can be used to integrate with external APIs and web services. It requires that the device is online and that Full Access is enabled, to make network requests. 

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

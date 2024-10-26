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

Autocomplete is an important part of the typing experience, where word suggestions can be presented in a toolbar above the keyboard as the user types.

In KeyboardKit, an ``AutocompleteService`` can provide suggestions and predictions to the main ``AutocompleteContext``. Unlike other services, there's no standard implementation of this protocol in the open-source SDK.

👑 [KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalService`` for on-device autocomplete, as well as a ``Autocomplete/RemoteService`` for integration with remote services. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Autocomplete Namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types and views, like a ``Autocomplete/Suggestion`` model, a ``Autocomplete/Toolbar`` component, etc.



## Autocomplete Context

KeyboardKit has an ``AutocompleteContext`` that provides observable autocomplete state that is kept up to date as the user types. It also has auto-persisted ``AutocompleteContext/settings-swift.property``.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever autocomplete is performed.



## Autocomplete Settings

The ``AutocompleteContext``'s ``AutocompleteContext/settings-swift.property`` property has auto-persisted properties that can be used to customize the autocomplete behavior, and that can be bound to components in a settings screen.



## Autocomplete Services

In KeyboardKit, an ``AutocompleteService`` can provide suggestions when the user types or the text input cursor moves in the text.

KeyboardKit doesn't have a standard autocomplete service. Instead, it injects a ``AutocompleteService/disabled`` service into ``KeyboardInputViewController/services`` until you register [KeyboardKit Pro][pro] or inject your own service implementation.

KeyboardKit Pro unlocks a ``Autocomplete/LocalService``, which performs on-device autocomplete, and a ``Autocomplete/RemoteService``, which can be used to integrate with any remote, REST-based APIs.



## How to perform autocomplete

The ``KeyboardInputViewController`` will automatically call ``KeyboardController/performAutocomplete()`` whenever the keyboard text changes, then update the ``Keyboard/State/autocompleteContext`` with the result from the ``Keyboard/Services/autocompleteService``.

You can configure the ``Keyboard/State/autocompleteContext`` and override ``KeyboardInputViewController``'s autocomplete properties and functions to customize the keyboard's autocomplete behavior.

The ``KeyboardView`` will automatically add an ``Autocomplete``.``Autocomplete/Toolbar`` that lists the autocomplete context ``AutocompleteContext/suggestions`` and also gives the keyboard some additional top space for callouts to render without being clipped.



## How to perform next word prediction

System-based next word prediction stopped working in iOS 16, but you can inject a custom ``Autocomplete/NextWordPredictionRequest`` into KeyboardKit Pro's ``Autocomplete/LocalService`` to make it perform next word prediction.

KeyboardKit Pro defines different request types for different web-based services. For instance ``Autocomplete/NextWordPredictionRequest/claude(apiKey:model:)`` can be used to integrate with the remote Claude API.

The easiest way to enable next word prediction is to add a ``KeyboardApp/AutocompleteConfiguration/nextWordPredictionRequest`` to your ``KeyboardApp``. KeyboardKit Pro will then inject that request when it sets up the standard ``Autocomplete/LocalService``.

> Important: Next word prediction requests are only available in KeyboardKit Pro Gold, and will by default require you to use your own API keys. This means that you will get individually billed for your consumption by the service provider that you choose. Reach out if you want KeyboardKit Pro to manage this account as part of your license agreement.



## How to create a custom autocomplete service

You can create a custom autocomplete service to customize the autocomplete behavior, to integrate with 3rd party tools, etc. You can implement ``AutocompleteService`` from scratch, or inherit and customize any of the [KeyboardKit Pro][Pro] services. 

For instance, here's a custom service that just adds a suffix to the current word:

```swift
class CustomAutocompleteService: AutocompleteService {

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
        let currentWord = text.wordFragmentAtEnd
        if currentWord == match {
            return matchSuggestions()
        } else {
            return fakeSuggestions(for: text)
        }
    }
}

private extension CustomAutocompleteService {
    
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

To use this service instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.autocompleteService = CustomAutocompleteService()
        setup(for: .myApp)  // See the getting-started guide
    }
}
```

This will make KeyboardKit use your custom autocomplete service instead of the standard one.



## Views

The ``Autocomplete`` namespace has autocomplete-specific views, that can be used to mimic native autocomplete toolbars and items.

@TabNavigator {
    
    @Tab("Toolbar") {
        @Row {
            @Column {
                ![AutocompleteToolbar](autocompletetoolbar)
            }
            @Column {
                The autocomplete ``Autocomplete/Toolbar`` mimics a native autocomplete bar, and can be used to present autocomplete suggestions to the user.
         
                This view can be styled with ``Autocomplete``.``Autocomplete/ToolbarStyle``, which can be applied with the ``SwiftUICore/View/autocompleteToolbarStyle(_:)`` view modifier. 
                
                You can also use custom item and separator views, or apply item- and separator-specific style view modifiers for granular control.
            }
        }
    }
}


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalService`` and ``Autocomplete/RemoteService`` and injects a ``Autocomplete/LocalService`` into ``KeyboardInputViewController/services`` when you register a valid license key. These services are open to inheritance, so you can inherit and customize them to fit your needs.


### Local Autocomplete

The ``Autocomplete/LocalService`` performs autocomplete operations locally, on-device. It supporst most keyboard locales, works offline, doesn't require Full Access and can integrate with system services, like the local lexicon.

**Supported locales:** arabic, bulgarian, czech, danish, dutch, dutch_belgium, english, english_gb, english_us, filipino, finnish, french, french_belgium, french_switzerland, german, german_austria, german_switzerland, greek, hebrew, hungarian, irish, italian, norwegian, polish, portuguese_brazil, portuguese, romanian, russian, spanish, swedish, turkish, ukrainian.

To support other locales, you must use a remote autocomplete service or create a custom service implementation.

You can inject a custom ``Autocomplete/NextWordPredictionRequest`` into the service to make it perform next word predictions, using external AI-based services. See the next word prediction section earlier in this article.


### Remote Autocomplete

The ``Autocomplete/RemoteService`` can be used to perform autocomplete by integrating with an external API. It requires that the device is online, and requires that Full Access is enabled, to allow the keyboard to make network requests.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

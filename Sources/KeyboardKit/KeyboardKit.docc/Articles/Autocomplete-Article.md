# Autocomplete

This article describes the KeyboardKit autocomplete engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Autocomplete is an important part of the typing experience, where word suggestions can be presented in a toolbar above the keyboard as the user types, and incorrectly text can be autocorrected.

In KeyboardKit, an ``AutocompleteService`` can provide suggestions and predictions to the main ``AutocompleteContext``. Unlike other services, there's no standard service implementation in the open-source SDK.

👑 [KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalService`` for on-device autocomplete, as well as a ``Autocomplete/RemoteService`` for integration with remote REST-APIs services. It also enables AI-powered next word predictions. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types and views, like a ``Autocomplete/Suggestion`` model, a ``Autocomplete/Toolbar`` component, etc.



## Context

KeyboardKit has an ``AutocompleteContext`` that provides observable autocomplete state that is kept up to date as the user types. It also has auto-persisted ``AutocompleteContext/settings-swift.property`` that can be used to customize the autocomplete behavior, toggle features on and off, etc.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever autocomplete is performed.



## Services

In KeyboardKit, an ``AutocompleteService`` can provide suggestions when the user types or the text input cursor moves in the text.

KeyboardKit doesn't have a standard autocomplete service. Instead, it injects a ``AutocompleteService/disabled`` service into ``KeyboardInputViewController/services`` until you register [KeyboardKit Pro][pro] or inject your own service implementation. Read more further down.



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
         
                This view can be styled with a ``Autocomplete/ToolbarStyle``, which can be applied with the ``SwiftUICore/View/autocompleteToolbarStyle(_:)`` modifier. 
                
                You can also use completely custom item & item separator views.
                
                This view is used as the standard toolbar by the ``KeyboardView``. This means that you can style it with a global style modifier.
            }
        }
    }
}


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalService`` and ``Autocomplete/RemoteService`` and injects a ``Autocomplete/LocalService`` into ``KeyboardInputViewController/services`` when you register a valid license. These services are open to inheritance, so you can inherit and customize them to fit your needs.


### Local Autocomplete

The ``Autocomplete/LocalService`` performs autocomplete operations locally, on-device. It supporst many keyboard locales, works offline, doesn't require Full Access and can integrate with system services, like the local lexicon.

The service supports: **arabic, bulgarian, czech, danish, dutch, dutch_belgium, english, english_gb, english_us, filipino, finnish, french, french_belgium, french_switzerland, german, german_austria, german_switzerland, greek, hebrew, hungarian, irish, italian, norwegian, polish, portuguese_brazil, portuguese, romanian, russian, spanish, swedish, turkish, ukrainian**.

You can inject a custom ``Autocomplete/NextWordPredictionRequest`` into the service to make it perform next word predictions, using external AI-based services. See the next word prediction section further down.


### Remote Autocomplete

The ``Autocomplete/RemoteService`` can be used to perform autocomplete by integrating with an external API. It requires that the device is online, and requires that Full Access is enabled, to allow the keyboard to make network requests.


### Next Character Prediction

The ``Autocomplete/LocalService`` and ``Autocomplete/RemoteService`` will automatically perform next-character predictions based on the result. This prediction result will be used by ``KeyboardView`` to increase the tap area of more probable keys, to reduce the risk of incorrect key taps.

You can disable next-character predictions with the ``AutocompleteContext`` ``AutocompleteContext/Settings-swift.struct/isNextCharacterPredictionEnabled`` setting.


### Next Word Prediction (BETA)

Apple's native text prediction utilities stopped supporting next word prediction in iOS 16, which means that we can only complete and correct words that we have started typing.

KeyboardKit Pro therefore unlocks ways to inject 3rd party support for performing next word prediction, by specifying a ``Autocomplete/NextWordPredictionRequest``in your ``KeyboardApp``'s ``KeyboardApp/autocompleteConfiguration-swift.property``:

```swift
extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            ...
            autocompleteConfiguration: .init(
                nextWordPredictionRequest: .claude(apiKey: ...)
            )
        )
    }
}
```

This will automatically inject the request into the ``Autocomplete/LocalService`` when your license is registered. Use the ``AutocompleteContext`` ``AutocompleteContext/Settings-swift.struct/isNextWordPredictionEnabled`` to disable this feature if needed, e.g. when a user opts out of using it.

KeyboardKit Pro currently only provides a ``Autocomplete/NextWordPredictionRequest/claude(apiKey:apiVersion:apiUrl:model:maxTokens:system:)`` request, but will add support for more 3rd party services in the future. All requests require that you use your own API keys.

> Warning: AI-based next word prediction requires Full Access for the keyboard to communicate with the remote service, and will send the user's text to that remote service. Make sure to explicitly get the users consent before activating this feature.

---

## How to...


### Perform autocomplete

The ``KeyboardInputViewController`` will automatically call ``KeyboardController/performAutocomplete()`` whenever the keyboard text changes, then update the ``Keyboard/State/autocompleteContext`` with the result from the ``Keyboard/Services/autocompleteService``.

You can configure the ``Keyboard/State/autocompleteContext`` and override ``KeyboardInputViewController``'s autocomplete properties and functions to customize the keyboard's autocomplete behavior.

The ``KeyboardView`` will automatically add an ``Autocomplete``.``Autocomplete/Toolbar`` that lists the autocomplete context ``AutocompleteContext/suggestions`` and also gives the keyboard some additional top space for callouts to render without being clipped.



### Create a custom autocomplete service

You can create a custom autocomplete service to customize the autocomplete behavior or integrate with 3rd party services. You can implement ``AutocompleteService`` from scratch, or inherit and customize any of the [KeyboardKit Pro][Pro] services:

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

To use this service instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/autocompleteService`` property:

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






[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

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

👑 [KeyboardKit Pro][Pro] unlocks an on-device ``Autocomplete/LocalAutocompleteService`` and a ``Autocomplete/RemoteAutocompleteService`` for integration with external APIs, plus next character prediction, next word prediction, etc. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types and views, like a ``Autocomplete/Suggestion`` model, a ``Autocomplete/Toolbar`` component, etc.



## Context

KeyboardKit has an ``AutocompleteContext`` that provides observable autocomplete state that is kept up to date as the user types. It also has auto-persisted ``AutocompleteContext/settings-swift.property`` that can be used to customize the autocomplete behavior, toggle features, etc.

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
                The autocomplete ``Autocomplete/Toolbar`` can be used to show autocomplete suggestions as the user types.
         
                The view can be styled with a ``Autocomplete/ToolbarStyle``, which is applied with the ``SwiftUICore/View/autocompleteToolbarStyle(_:)`` modifier. It can also use completely custom views.
                
                This view is used as the standard toolbar by the ``KeyboardView``. This means you can style it with a global style modifier.
            }
        }
    }
}


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalAutocompleteService`` and ``Autocomplete/RemoteAutocompleteService`` and injects the local service into ``KeyboardInputViewController/services`` when you register a valid license. You can inherit these services and customize them to your needs.


### Local Autocomplete

The ``Autocomplete/LocalAutocompleteService`` performs on-device autocomplete. It supports many locales, works offline, doesn't require Full Access and can integrate with system services, like the local lexicon.

The service supports: **arabic, bulgarian, czech, danish, dutch, dutch_belgium, english, english_gb, english_us, filipino, finnish, french, french_belgium, french_switzerland, german, german_austria, german_switzerland, greek, hebrew, hungarian, irish, italian, norwegian, polish, portuguese_brazil, portuguese, romanian, russian, spanish, swedish, turkish, ukrainian**.

You can inject a custom ``Autocomplete/NextWordPredictionRequest`` into the service to make it perform next word predictions, using external AI-based services. See the next word prediction section further down.


### Remote Autocomplete

The ``Autocomplete/RemoteAutocompleteService`` can be used to perform autocomplete by integrating with an external API. It requires that the device is online, and requires that Full Access is enabled, to allow the keyboard to make network requests.

You create a custom remote autocomplete service by defining which URL to call, any potential headers or query parameters, as well as a result type that can parse the remote request response. 


### Next Character Prediction

The ``Autocomplete/LocalAutocompleteService`` and ``Autocomplete/RemoteAutocompleteService`` will perform next-character predictions based on the result. This information is used by ``KeyboardView`` to increase the tap area of probable keys, to reduce the risk of incorrect typing.

You can disable next-character predictions with the ``AutocompleteContext`` ``AutocompleteContext/Settings-swift.struct/isNextCharacterPredictionEnabled`` setting.


### Next Word Prediction (BETA)

Apple's on-device text prediction utilities stopped supporting next word prediction in iOS 16. KeyboardKit Pro therefore unlocks ways to let the local autocomplete service perform next word prediction via 3rd party AI services.

The easiest way to enable next word prediction, is to add a ``Autocomplete/NextWordPredictionRequest`` to your ``KeyboardApp`` configuration:

```swift
extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            ...
            autocomplete: .init(
                nextWordPredictionRequest: .claude(apiKey: ...)
            )
        )
    }
}
```

You can use these pre-defined requests to integrate with Claude or OpenAI, by providing an API key and any optional customizations:

* ``Autocomplete/NextWordPredictionRequest/claude(apiKey:apiUrl:anthropicVersion:model:maxTokens:systemPrompt:)`` 
* ``Autocomplete/NextWordPredictionRequest/openAI(apiKey:apiUrl:apiKeyHeader:apiKeyValuePrefix:model:maxTokens:systemPrompt:)``.

> Warning: AI-based next word prediction requires Full Access to be able to make network requests. This feature is also disabled by default, to avoid sending user text to 3rd party services without user consent. Make sure to explicitly get the user's consent before activating this feature, and enable it by setting the ``AutocompleteContext`` ``AutocompleteContext/Settings-swift.struct/isNextWordPredictionEnabled`` to true!


---

## How to...


### Perform autocomplete

The ``KeyboardInputViewController`` will automatically call ``KeyboardController/performAutocomplete()`` whenever the keyboard text changes, then update the ``Keyboard/State/autocompleteContext`` with the result from the ``Keyboard/Services/autocompleteService``.

You can configure the ``Keyboard/State/autocompleteContext`` and override ``KeyboardInputViewController``'s autocomplete properties and functions to customize the keyboard's autocomplete behavior.

The ``KeyboardView`` will automatically add an ``Autocomplete``.``Autocomplete/Toolbar`` that lists the autocomplete context ``AutocompleteContext/suggestions`` and also gives the keyboard some additional top space for callouts to render without being clipped.



### Create a custom autocomplete service

You can create a custom autocomplete service to customize the standard autocomplete behavior or integrate with 3rd party services. You can implement ``AutocompleteService`` from scratch, or inherit and customize any [KeyboardKit Pro][Pro] service, like this:

```swift
class CustomAutocompleteService: Autocomplete.LocalAutocompleteService {

    override func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion] {
        let original = super.autocompleteSuggestions(for: text)
        let reversed = original.reversed()
        return Array(reversed)
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

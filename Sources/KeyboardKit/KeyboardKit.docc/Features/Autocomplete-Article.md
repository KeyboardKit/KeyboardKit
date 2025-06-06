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

In KeyboardKit, an ``AutocompleteService`` can provide suggestions and predictions to the main ``AutocompleteContext``. Unlike other services, there is no standard autocomplete service in the open-source SDK.

👑 [KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalAutocompleteService`` and a ``Autocomplete/RemoteAutocompleteService``, next character prediction, next word prediction, etc. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has an ``Autocomplete`` namespace with autocomplete-related types, like a ``Autocomplete/Suggestion`` model, a ``Autocomplete/Toolbar`` view, etc.



## Context

KeyboardKit has an ``AutocompleteContext`` that provides observable autocomplete state, and auto-persisted ``AutocompleteContext/settings-swift.property`` that can be used to customize the autocomplete behavior.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever autocomplete is performed.



## Services

In KeyboardKit, an ``AutocompleteService`` can provide suggestions when the user types and the text input cursor moves in the text.

KeyboardKit doesn't have a standard autocomplete service, as it has for other service types. Instead, it injects a ``AutocompleteService/disabled`` service into ``KeyboardInputViewController/services`` until you set up [KeyboardKit Pro][pro] or inject your own service implementation.



## Settings

KeyboardKit has an ``AutocompleteSettings`` type with autocomplete-related settings. The context ``AutocompleteContext/settings-swift.property`` is used by default.



## Views

The ``Autocomplete`` namespace has autocomplete-specific views, that can be used to mimic native autocomplete toolbars and items.

@TabNavigator {
    
    @Tab("Toolbar") {
        @Row {
            @Column {
                ![AutocompleteToolbar](autocomplete-toolbar)
            }
            @Column {
                The autocomplete ``Autocomplete/Toolbar`` can be used to show autocomplete suggestions as the user types.
         
                The view can be styled with a ``Autocomplete/ToolbarStyle``, which is applied with the ``SwiftUICore/View/autocompleteToolbarStyle(_:)`` modifier. It can also use completely custom views.
                
                This view is used as the standard toolbar by the ``KeyboardView``. You can style it with a global style modifier.
            }
        }
    }
}


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalAutocompleteService`` and a ``Autocomplete/RemoteAutocompleteService``, and injects a local service into ``KeyboardInputViewController/services`` when you set up KeyboardKit Pro. You can inherit both classes to customize their functionality.

KeyboardKit Pro also unlocks an ``Emoji``.``Emoji/ColonSearch`` engine that can be used to add emoji suggestions to the autocomplete result, as well as next character prediction and next word prediction.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Local Autocomplete

The ``Autocomplete/LocalAutocompleteService`` performs on-device autocomplete. It works offline, doesn't require Full Access, integrates with system services like the local lexicon, and supports the following languages: 

@TabNavigator {
    
    @Tab("iOS, iPadOS, visionOS") {
        Arabic, Arabic, Najdi, Bulgarian (Bulgaria), Czech (Czechia), Danish (Denmark), Dutch (Netherlands), English (Australia), English (Canada), English (India), English (New Zealand), English (Singapore), English (South Africa), English (United Kingdom), English (United States), Finnish (Finland), French (France), German (Germany), Greek (Greece), Hebrew (Israel), Hindi, Hungarian (Hungary), Icelandic (Iceland), Indonesian (Indonesia), Irish (Ireland), Italian (Italy), Lithuanian (Lithuania), Norwegian Bokmål (Norway), Norwegian Nynorsk, Polish (Poland), Portuguese (Brazil), Portuguese (Portugal), Punjabi, Romanian (Romania), Russian (Russia), Slovenian (Slovenia), Spanish (Mexico), Spanish (Spain), Swedish (Sweden), Telugu, Turkish (Türkiye), Ukrainian (Ukraine), Vietnamese (Vietnam)
    }
    
    @Tab("macOS") {
        Arabic, Arabic, Najdi, Bulgarian, Czech, Danish, Dutch, English, English (Australia), English (Canada), English (India), English (Japan), English (New Zealand), English (Singapore), English (South Africa), English (United Kingdom), Finnish, French, German, Greek, Hebrew, Hindi, Hungarian, Icelandic, Indonesian, Irish, Italian, Korean, Lithuanian, Norwegian Bokmål, Norwegian Nynorsk, Polish, Portuguese (Brazil), Portuguese (Portugal), Punjabi, Romanian, Russian, Slovenian, Spanish, Swedish, Telugu, Turkish, Ukrainian, Vietnamese
    }
}

The service will use perform emoji autocomplete if ``AutocompleteSettings/isEmojiAutocompleteEnabled`` is enabled. You can also inject a ``Autocomplete/NextWordPredictionRequest`` to make the service perform next word predictions with an external AI service. 


### Remote Autocomplete

The ``Autocomplete/RemoteAutocompleteService`` can be used to perform autocomplete by integrating with any external API. It requires that the device is online, and requires Full Access to be able to make network requests.

You create a remote autocomplete service by defining the API URL, any potential headers or query parameters, as well as a result type.


### Autocomplete vs. autocorrect

Autocomplete suggestions with a ``Autocomplete/SuggestionType/regular`` type are only applied if the user taps on them, while suggestions with the ``Autocomplete/SuggestionType/autocorrect`` type will be automatically applied when the user taps on a word delimiter, like space.

The ``Autocomplete/LocalAutocompleteService`` will try its best to provide proper autocorrections, but sometimes it will fail to do so. If so, you can add custom values to the ``AutocompleteContext/autocorrectDictionary`` dictionary.


### Next Character Prediction

The ``Autocomplete/LocalAutocompleteService`` and ``Autocomplete/RemoteAutocompleteService`` perform next-character predictions on their results.

This information is used by ``KeyboardView`` to slightly increase the tap area of more probable keys, to reduce the risk of typing error.


### Next Word Prediction

Apple's native text prediction utilities stopped supporting next word prediction in iOS 16. It instead only provides predictions on already typed text, without any (known) way to get next word predictions. 

KeyboardKit Pro therefore unlocks ways to perform next word prediction via 3rd party AI services. The easiest way to enable next word prediction, is to add a Claude- or OpenAI-based ``Autocomplete/NextWordPredictionRequest`` to your ``KeyboardApp``:

```swift
extension KeyboardApp {

    static var keyboardKitDemo: KeyboardApp {
        KeyboardApp(
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

You can also let your users select which next word prediction request to use, with their own private API key. Read more further down.

> Important: AI-based next word prediction requires Full Access. It's disabled by default, to avoid sending typed text to 3rd parties without the user's explicit consent. When a user has given its explicit content, you can enable it with ``AutocompleteSettings/isNextWordPredictionEnabled``.


### User-Specific Next Word Prediction

You can let your users use their own next word prediction integrations, use their own API key and pay for their own data consumption. 

Just give your users a way to define a ``AutocompleteSettings/nextWordPredictionRequestType`` and a ``AutocompleteSettings/nextWordPredictionRequestApiKey``. ``AutocompleteSettings`` will then provide you with a properly configured ``AutocompleteSettings/nextWordPredictionRequest`` for that information.

KeyboardKit Pro's ``KeyboardApp/SettingsScreen`` has a visibility setting to show a next word prediction section. This section is hidden by default.


---

## How to...


### ...perform autocomplete

The ``KeyboardInputViewController`` will automatically call ``KeyboardController/performAutocomplete()`` whenever the keyboard text changes, or the input cursor is moved, after which it updates the ``Keyboard/State/autocompleteContext`` with the ``Keyboard/Services/autocompleteService`` result.

You can configure the ``Keyboard/State/autocompleteContext``, override the ``KeyboardInputViewController``'s autocomplete properties and functions, and replace the ``Keyboard/Services/autocompleteService`` with a custom service, to customize the autocomplete behavior.

The ``KeyboardView`` automatically adds an autocomplete ``Autocomplete/Toolbar`` to list ``AutocompleteContext/suggestions`` and provide extra top space for callouts.



### ...enable emoji autocomplete 

KeyboardKit Pro unlocks an emoji ``Emoji/ColonSearch`` engine that makes it possible to search for emojis by starting the current word with a colon. This is automatically used by ``Autocomplete/LocalAutocompleteService`` when ``AutocompleteSettings/isEmojiAutocompleteEnabled`` is true.



### ...create a custom autocomplete service

You can create a custom autocomplete service to customize the autocomplete behavior or integrate with 3rd party services. You can the implement ``AutocompleteService`` protocol from scratch, or inherit and customize any [KeyboardKit Pro][Pro] service:

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

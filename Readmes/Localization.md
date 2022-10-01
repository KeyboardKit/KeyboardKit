# Localization

KeyboardKit is localized in 50+ keyboard-specific locales:

* 🇺🇸 English (Default)

* 🇦🇱 Albanian
* 🇦🇪 Arabic
* 🇧🇾 Belarusian
* 🇧🇬 Bulgarian
* 🇦🇩 Catalan
* 🇭🇷 Croatian
* 🇨🇿 Czech
* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇧🇪 Dutch (Belgium)
* 🇬🇧 English (UK)
* 🇺🇸 English (US)
* 🇪🇪 Estonian
* 🇫🇴 Faroese
* 🇵🇭 Filipino
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇧🇪 French (Belgium)
* 🇨🇭 French (Switzerland)
* 🇬🇪 Georgian
* 🇩🇪 German
* 🇦🇹 German (Austria)
* 🇨🇭 German (Switzerland)
* 🇬🇷 Greek
* 🇭🇺 Hungarian
* 🇮🇸 Icelandic
* 🇮🇪 Irish
* 🇮🇹 Italian
* 🇹🇯 Kurdish Sorani
* 🇹🇯 Kurdish Sorani (Arabic)
* 🇹🇯 Kurdish Sorani (PC)
* 🇱🇻 Latvian
* 🇱🇹 Lithuanian
* 🇲🇰 Macedonian
* 🇲🇹 Maltese
* 🇲🇳 Mongolian
* 🇳🇴 Norwegian
* 🇮🇷 Persian
* 🇵🇱 Polish
* 🇵🇹 Portuguese
* 🇧🇷 Portuguese (Brazil)
* 🇷🇴 Romanian
* 🇷🇺 Russian
* 🇷🇸 Serbian
* 🇷🇸 Serbian (Latin)
* 🇸🇮 Slovenian
* 🇸🇰 Slovak
* 🇪🇸 Spanish
* 🇸🇪 Swahili
* 🇰🇪 Swedish
* 🇹🇷 Turkish
* 🇺🇦 Ukrainian

These locales can be accessed with the `KeyboardLocale` enum.

Each locale provides localized strings and locale information. KeyboardKit Pro then provides support for fully localized input sets, keyboard layouts, callout actions etc.


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized strings for all locales. These texts are used to localize certain buttons, labels etc.

Localized strings are stored in `Sources/Resources`.


## Localized keyboards

A completely localized keyboard doesn't just involve localized strings. To fully localize a keyboard, you must implement locale-specific input sets, keyboard layouts, callout actions etc.

While KeyboardKit only provides localized strings, locale information and a localized English keyboard, [KeyboardKit Pro][Pro] provides completely localized keyboards for all keyboard locales. 


## How to add a new locale

Note that `KeyboardContext` don't rely on the KeyboardKit-specific `KeyboardLocale`, but rather on the general `Locale` type. This means that you don't need to add more `KeyboardLocale`s to create keyboards that are localized in oher languages.

However, if you DO need to add a new `KeyboardLocale`, there are a number of things that you need to do, as mentioned above. Please see the documentation for more information.


## KeyboardKit Pro

KeyboardKit Pro provides completely localized keyboards for all keyboard locales, including locale-specific input sets, keyboard layouts and callout actions.

[Read more here][Pro].


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

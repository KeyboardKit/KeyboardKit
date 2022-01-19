# Localization

KeyboardKit is localized in 46 keyboard-specific locales:

* 🇺🇸 English (Default)

* 🇦🇱 Albanian
* 🇦🇪 Arabic
* 🇧🇾 Belarusian
* 🇧🇬 Bulgarian
* 🇨🇿 Czech
* 🇭🇷 Croatian
* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇧🇪 Dutch (Belgium)
* 🇬🇧 English (UK)
* 🇺🇸 English (US)
* 🇪🇪 Estonian
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇧🇪 French (Belgium)
* 🇨🇭 French (Switzerland)
* 🇩🇪 German
* 🇦🇹 German (Austria)
* 🇨🇭 German (Switzerland)
* 🇬🇷 Greek
* 🇭🇺 Hungarian
* 🇮🇸 Icelandic
* 🇮🇪 Irish
* 🇮🇹 Italian
* 🇹🇯 Kurdish Sorani
* 🇱🇻 Latvian
* 🇱🇹 Lithuanian
* 🇲🇰 Macedonian
* 🇲🇹 Maltese
* 🇳🇴 Norwegian
* 🇮🇷 Persian
* 🇵🇱 Polish
* 🇵🇹 Portuguese
* 🇧🇷 Portuguese (Brazil)
* 🇷🇴 Romanian
* 🇲🇩 Romanian (Moldova)
* 🇷🇺 Russian
* 🇷🇸 Serbian
* 🇷🇸 Serbian (Latin)
* 🇸🇮 Slovenian
* 🇸🇰 Slovak
* 🇪🇸 Spanish
* 🇸🇪 Swedish
* 🇹🇷 Turkish
* 🇺🇦 Ukrainian

These locales can be accessed with the `KeyboardLocale` enum.

Each locale provides localized strings and locale information. KeyboardKit Pro then provides support for fully localized input sets, keyboard layouts, callout actions etc.


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized strings for all locales. These texts are used to localize certain buttons, labels etc.

Localized strings are stored in `Sources/Resources`.


## Localized keyboards

A completely localized keyboard doesn't just involve localized strings.

To fully localize a keyboard, you must implement locale-specific input sets, keyboard layouts, callout actions etc.

While KeyboardKit only provides localized strings, locale information and a localized English keyboard, [KeyboardKit Pro][Pro] provides completely localized keyboards for all keyboard locales.


## How to add a new locale

Adding a new locale to KeyboardKit requires the following:

* Define the new `KeyboardLocale` case.
* Define its properties, like `flag`, `isLeftToRight` etc.
* Provide a `Resources/<id>.lproj` folder with localized strings.
* Implement a custom `CalloutActionProvider`.
* Implement a custom `InputSetProvider`.

If the locale generates a keyboard that looks off, you can either implement a new `KeyboardLayoutProvider` or adjust the `iPhoneKeyboardLayoutProvider` and `iPadKeyboardLayoutProvider` to handle the new layout.

New locales must ensure that the keyboard layout is correct for:

* iPhone portrait
* iPhone landscape
* iPad portrait
* iPad landscape  

This involves specifying margins, system actions etc. to make the keyboard behave correctly for all these cases.


## KeyboardKit Pro

KeyboardKit Pro provides completely localized keyboards for all keyboard locales, including locale-specific input sets, keyboard layouts and callout actions.

[Read more here][Pro].


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

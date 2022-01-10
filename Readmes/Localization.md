# Localization

KeyboardKit defines keyboard-specific locales and provides localized content for the supported locales.


## Keyboard Locales

KeyboardKit is localized in the following languages:

* 🇺🇸 English

* 🇦🇱 Albanian
* 🇦🇪 Arabic
* 🇧🇾 Belarusian
* 🇨🇿 Czech
* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇧🇪 Dutch (Belgium)
* 🇬🇧 English (UK)
* 🇺🇸 English (US)
* 🇪🇪 Estonian
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇧🇪 French (Belgium)
* 🇩🇪 German
* 🇦🇹 German (Austria)
* 🇮🇸 Icelandic
* 🇮🇪 Irish
* 🇮🇹 Italian
* 🇹🇯 Kurdish Sorani
* 🇱🇻 Latvian
* 🇱🇹 Lithuanian
* 🇳🇴 Norwegian
* 🇮🇷 Persian
* 🇵🇱 Polish
* 🇵🇹 Portuguese
* 🇧🇷 Portuguese (Brazil)
* 🇷🇴 Romanian
* 🇷🇺 Russian
* 🇪🇸 Spanish
* 🇸🇪 Swedish
* 🇹🇷 Turkish
* 🇺🇦 Ukrainian

These locales can be accessed with the `KeyboardLocale` enum.


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized strings for all locales. These texts are used to localize certain buttons, labels etc.

Localized strings are managed under `Sources/Resources`.


## Localized keyboards

A completely localized keyboard doesn't just involve localized strings.

To fully localize a keyboard, you must implement a locale-specific input set, keyboard layout, callout actions etc.

While KeyboardKit only provides a completely localized English keyboard, [KeyboardKit Pro][Pro] provides completely localized keyboards for all keyboard locales.


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

# Localization

KeyboardKit defines keyboard-specific locales and provides localized content for the supported locales.


## Keyboard Locales

KeyboardKit is localized in the following languages:

* 🇺🇸 English

* 🇦🇱 Albanian
* 🇦🇪 Arabic
* 🇧🇷 Brazilian
* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇬🇧 English (UK)
* 🇺🇸 English (US)
* 🇪🇪 Estonian
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇩🇪 German
* 🇮🇸 Icelandic
* 🇮🇹 Italian
* 🇹🇯 Kurdish Sorani
* 🇱🇻 Latvian
* 🇱🇹 Lithuanian
* 🇳🇴 Norwegian
* 🇮🇷 Persian
* 🇵🇱 Polish
* 🇵🇹 Portuguese
* 🇷🇺 Russian
* 🇪🇸 Spanish
* 🇸🇪 Swedish
* 🇺🇦 Ukrainian

These locales can be accessed through the `KeyboardLocale` enum.


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized strings for all locales. These texts are used to localize certain buttons, labels etc.

Localized strings are managed under `Sources/Resources`.


## Localized keyboards

A completely localized keyboard doesn't just involve localized strings.

To fully localize a keyboard, you must implement a locale-specific input set, keyboard layout, secondary callout actions etc.

KeyboardKit only provides a completely localized English keyboard.

[KeyboardKit Pro][Pro] provides completely localized keyboards for all keyboard locales.


## Adding new locales

Adding a new locale to KeyboardKit requires the following:

* Define the new `KeyboardLocale` case.
* Define its properties, like `flag`, `isLeftToRight` etc.
* Provide a `Resources/<id>.lproj` folder with localized strings.
* Implement a custom `KeyboardInputSetProvider`.
* Implement a custom `SecondaryCalloutActionProvider`.

If the locale requires a keyboard layout that differs from a English, German or Russian layout, a new `KeyboardLayoutProvider` must be specified.

Custom keyboard locales must ensure that the keyboard layout is correct for:

* Each locale
* iPhone portrait
* iPhone landscape
* iPad portrait
* iPad landscape  

This involves specifying margins, system actions etc. to make the keyboard behave correctly for all these cases.


## KeyboardKit Pro

KeyboardKit Pro provides completely localized keyboards for all keyboard locales, including locale-specific input sets, keyboard layouts and secondary input actions.

[Read more here][Pro]. 


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

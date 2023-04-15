# Localization

This article describes the KeyboardKit localization model and how to use it.

In KeyboardKit, the ``KeyboardLocale`` enum defines all locales that are supported by the library in that each keyboard locale has localized content and KeyboardKit Pro can create a localized system keyboard for each of these locales.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Supported locales

KeyboardKit is localized in 60 keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 <br />

🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />

🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 <br />

Keyboard locales refer to native `Locale`s and have additional flag information as well as localized strings that can be translated using the ``KKL10n`` enum. All other locale-specific information can be retrieved from the native ``KeyboardLocale/locale``, such as the localized name, text and line direction etc.



## How to change the current keyboard locale 

You can change the current keyboard locale by setting the ``KeyboardInputViewController/keyboardContext``'s ``KeyboardContext/locale`` to a new `Locale` or use the more convenient setter functions that also supports using ``KeyboardLocale`` directly.

You can set the available locales for a keyboard extension by setting the ``KeyboardInputViewController/keyboardContext``'s ``KeyboardContext/locales`` to the locales you want to use. This makes it possible to switch locale using ``KeyboardContext/selectNextLocale()`` or a ``LocaleContextMenu``.

The reason why ``KeyboardContext`` uses a regular `Locale` and not a ``KeyboardLocale`` is that it should be possible to use any locales without having to create a new ``KeyboardLocale``.



## How to translate localized content

KeyboardKit defines localized strings for each locale in files that are kept under `Resources`. These localized strings can be accessed with the ``KKL10n`` enum.

For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``KeyboardLocale`` or `Locale`, you can use any of the various `text(for:)` functions:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, KeyboardKit lets you get a flag for a locale or keyboard locale, using the ``KeyboardLocale/flag`` property. 



## How to add a new locale to the library

Since ``KeyboardLocale`` is hard-coded into the library, you can add more keyboard locales by forking the library, adding what you need and create a pull request:

* Fork the KeyboardKit project and create a feature branch.
* Create a new ``KeyboardLocale`` case and define all required properties.
* Provide a `Resources/<id>.lproj` folder with localized strings for the new locale.
* Make sure that the code lints and all unit tests pass, then push your changes to your fork. 
* Create a pull request in the main repository, that refers to your specific fork and feature branch.

In the PR, please provide the following information:

* The locale identifier.
* Screenshots of how it looks on iPhone and iPad (if applicable).
* Any specific information that may be important to know about the locale

Once the locale is merged into the main repo, [KeyboardKit Pro][Pro] will add a ``CalloutActionProvider``, ``InputSetProvider`` and ``KeyboardLayoutProvider`` for the locale.   



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional localization capabilities.

KeyboardKit Pro unlocks an ``InputSetProvider``, ``KeyboardLayoutProvider`` and ``CalloutActionProvider`` for each ``KeyboardLocale``, which means that you can create a fully localized ``SystemKeyboard`` with a single line of code.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

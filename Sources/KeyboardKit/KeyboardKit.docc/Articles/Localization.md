# Localization

This article describes the KeyboardKit localization model and how to use it.

In KeyboardKit, the ``KeyboardLocale`` enum defines all supported locales, which include locale information such as localized names, flags etc., as well as localized strings that can be translated using the ``KKL10n`` enum.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Supported locales

KeyboardKit is localized in 60 keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 <br />

🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />

🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 <br />

Keyboard locales have more information than raw locales and can also have a set of related services. For instance, you can provide a ``CalloutActionProvider``, ``InputSetProvider`` and ``KeyboardLayoutProvider`` for each locale.



## How to change the current locale 

You can change the current locale for a keyboard extension by setting the ``KeyboardContext``'s ``KeyboardContext/locale`` to a new `Locale` or use the more convenient ``KeyboardContext/setLocale(_:)``, which supports using a ``KeyboardLocale``.

You can change the available locales of a keyboard extension by setting the ``KeyboardContext``'s ``KeyboardContext/locales`` to the ones you want to use. This makes it possible to loop through the available locales with ``KeyboardContext/selectNextLocale()``.

The reason why ``KeyboardContext`` uses a regular `Locale` and not a ``KeyboardLocale`` is that it should be possible to use any locales without having to create a new ``KeyboardLocale``.



## How to use localized content

KeyboardKit defines localized strings for each locale in files that are kept under `Resources`. These localized strings can be accessed with the ``KKL10n`` enum.

For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain locale, you can use any of the various `text(for:)` functions:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, KeyboardKit lets you get a flag for a locale or keyboard locale, using the ``LocaleFlagProvider/flag`` property. 



## How to add a new locale to the library

Since ``KeyboardLocale`` is hard-coded into the library, you can add more locales by either forking the library and adding what you need, or provide a new locale in a pull request and ask for it to get added to the main library.

Adding a new locale to KeyboardKit involves the following steps:

* Create a new ``KeyboardLocale`` case.
* Define its properties, like ``KeyboardLocale/flag``, ``KeyboardLocale/isLeftToRight`` etc.
* Provide a `Resources/<id>.lproj` folder with localized strings.
* Create a PR with information about the locale's input sets, callout actions and keyboard layout.

If the locale is merged into the main repo, [KeyboardKit Pro][Pro] will add a ``CalloutActionProvider``, ``InputSetProvider`` and ``KeyboardLayoutProvider`` for the locale.   



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional localization capabilities.

KeyboardKit Pro unlocks an ``InputSetProvider``, ``KeyboardLayoutProvider`` and ``CalloutActionProvider`` for each ``KeyboardLocale``, which means that you can create a fully localized ``SystemKeyboard`` with a single line of code.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

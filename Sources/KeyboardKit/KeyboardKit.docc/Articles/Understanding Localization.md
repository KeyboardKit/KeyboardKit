# Understanding Localization

This article describes the KeyboardKit localization model and how to use it.


## Supported locales

KeyboardKit is localized in 60 keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 <br />

🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />

🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 <br />

KeyboardKit provides a ``KeyboardLocale`` for each locale, as well as localized content, such as strings that can be translated with ``KKL10n``.

KeyboardKit Pro unlocks an ``InputSetProvider`` and a ``CalloutActionProvider`` for each locale, which means that ``SystemKeyboard`` becomes fully localized for every ``KeyboardLocale``.



## Keyboard locale

The ``KeyboardLocale`` enum defines all keyboard-specific locales that are supported by the library.

Keyboard locales have more information than raw locales and can also have a set of related services. For instance, when a [KeyboardKit Pro][Pro] license is registered, it unlocks ways to get a ``CalloutActionProvider`` and an ``InputSetProvider`` for each locale.



## How to change the current locale 

You can change the current locale for a keyboard extension by setting the ``KeyboardContext`` ``KeyboardContext/locale`` to a new `Locale` or use the more convenient ``KeyboardContext/setLocale(_:)``, which supports using a ``KeyboardLocale``.

You can change the available locales of a keyboard extension by setting ``KeyboardContext`` ``KeyboardContext/locales`` to the locales you want to use. This makes it possible to loop through the available locales with ``KeyboardContext/selectNextLocale()``.

The reason why ``KeyboardContext`` uses a regular `Locale` and not a ``KeyboardLocale`` is that it should be possible to use any locales without having to create a new ``KeyboardLocale``.



## How to use localized content

KeyboardKit defines localized strings for each locale in files that are kept under `Resources`. These localized strings can be accessed with the ``KKL10n`` enum.

For instance, to translate the numeric button key for the current locale, you can use ``KKL10n/text``:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain locale, you can use `text(for:)`:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, KeyboardKit lets you get a flag for a locale or keyboard locale, using the ``LocaleFlagProvider/flag`` property. 



## How to add a new locale to the library

Since ``KeyboardLocale``s are hard-coded into the library, you can add more locales by either forking the library and adding what you need, or provide a new locale in a pull request and ask for it to get added to the main library.

Adding a new locale to KeyboardKit involves the following steps:

* Create a new ``KeyboardLocale`` case.
* Define its properties, like ``KeyboardLocale/flag``, ``KeyboardLocale/isLeftToRight`` etc.
* Provide a `Resources/<id>.lproj` folder with localized strings.
* Create a locale-specific ``InputSet``.
* Make sure that the input set looks great on iPhone and iPad, in portrait and landscape.
* Make changes to ``iPhoneKeyboardLayoutProvider`` and ``iPadKeyboardLayoutProvider`` if needed.
* Make sure that the unit tests pass.

For a new keyboard locale to be accepted to the main library, you must also provide a list of locale-specific callout actions, since the locale must be fully supported by [KeyboardKit Pro][Pro].

If you contribute a new keyboard locale that gets merged into the main library, you will get a free [KeyboardKit Pro][Pro] license for one app.   



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

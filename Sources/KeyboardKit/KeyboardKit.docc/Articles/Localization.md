# Localization

This article describes the KeyboardKit localization model and how to use it.

In KeyboardKit, the ``KeyboardLocale`` enum defines keyboard-specific locales. Each keyboard locale has localized content and assets and specifies a native `Locale` that provides locale-specific information.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Supported locales

KeyboardKit supports 60 keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 <br />

🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />

🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 <br />

Each keyboard locale refers to a native `Locale`s and have additional flag information as well as localized strings that can be translated using the ``KKL10n`` enum. All other locale-specific information can be retrieved from the native ``KeyboardLocale/locale``, such as the localized name, text and line direction etc.



## How to change the current keyboard locale 

You can change the current keyboard locale by setting the ``KeyboardInputViewController/keyboardContext`` ``KeyboardContext/locale`` or use the more convenient setter functions that support using both `Locale` and ``KeyboardLocale``.

You can set the available locales for a keyboard extension by setting the ``KeyboardInputViewController/keyboardContext`` ``KeyboardContext/locales`` to the locales you want to use. This makes it possible to switch locale using ``KeyboardContext/selectNextLocale()`` or a ``LocaleContextMenu``.

The reason why ``KeyboardContext`` uses a regular `Locale` and not a ``KeyboardLocale`` is that it should be able to use any locales without having to create a new ``KeyboardLocale``.



## How to translate localized content

Each ``KeyboardLocale`` has localized strings in a file that is kept under `Resources`. These localized strings can be accessed with the ``KKL10n`` enum.

For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``KeyboardLocale`` or `Locale`, you can use any of the various `text(for:)` functions:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, KeyboardKit lets you get a flag for a locale or keyboard locale, using the ``KeyboardLocale/flag`` property. 



## How to add a new keyboard locale

Since each ``KeyboardLocale`` is hard-coded into the library, new keyboard locales must be hard-coded in the same way.

You can add new keyboard locales by following these steps:

* Fork the KeyboardKit project and create a feature branch.
* Create a new ``KeyboardLocale`` case and define all required properties.
* Provide a `Resources/<id>.lproj` folder with localized strings for the new locale.
* Make sure that linting works and that all tests pass, then push your changes to your fork. 
* Create a pull request in the main KeyboardKit repository, from your specific fork and feature branch.

In the PR, please provide any additional information that is needed to correctly support the locale.

Usage of the various keys can be found in the following places:

* `done` - Apple Calendar, when adding new activity and tapping place or video call.
* `go` - Mobile Safari, when typing a url.  
* `join` - System Settings, when joining a wi-fi network with password.
* `next` - System Settings, when joining an enterprise wi-fi network with username and password.
* `ok` - A standard OK button.
* `return` - Apple Notes, when typing.
* `search` - Mobile Safari, when typing in the google.com search bar.
* `send` - Some chat apps (WeChat, QQ), when typing in a chat text field.
* `space` - The text that is displayed on the space bar.

Once the locale is merged into the main repo, [KeyboardKit Pro][Pro] will add a ``CalloutActionProvider``, ``InputSetProvider`` and ``KeyboardLayoutProvider`` for the locale.   



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional localization capabilities.

KeyboardKit Pro unlocks an ``InputSetProvider``, ``KeyboardLayoutProvider`` and ``CalloutActionProvider`` for each ``KeyboardLocale``, which means that you can create a fully localized ``SystemKeyboard`` with a single line of code.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

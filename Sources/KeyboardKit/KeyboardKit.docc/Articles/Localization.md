# Localization

This article describes the KeyboardKit localization engine.

In KeyboardKit, the ``KeyboardLocale`` enum defines keyboard locales, where each locale refers to a native `Locale` and has localized strings and assets.

[KeyboardKit Pro][Pro] features are described at the end of this document.



## Supported locales

KeyboardKit supports 61 keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 <br />

🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 <br />

🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 <br />

🇺🇿 <br />

Each locale refers to a native `Locale`s and has additional flag information, as well as localized strings that can be translated with the ``KKL10n`` enum.



## How to change the current keyboard locale 

You can change the current keyboard locale by setting the ``KeyboardInputViewController/keyboardContext`` ``KeyboardContext/locale`` or use the more setter functions that support both `Locale` and ``KeyboardLocale``. 

Setting the locale will update the controller's `primaryLanguage`, which controls things like spellchecking and text direction. Note that it always returns `nil`, even after being set.

You can set the available locales for a keyboard extension by setting the ``KeyboardInputViewController/keyboardContext`` ``KeyboardContext/locales`` to the locales you want to use. This makes it possible to switch locale using ``KeyboardContext/selectNextLocale()`` or a ``LocaleContextMenu``.

The reason why ``KeyboardContext`` uses a regular `Locale` and not a ``KeyboardLocale`` is that it should be able to use any locales without having to create a new ``KeyboardLocale``.



## How to use LTR and RTL locales

KeyboardKit supports LTR (Left-To-Right) and RTL (Right-To-Left) locales.

You don't need to configure your keyboard extension to support RTL. Just change the keyboard locale as explained above, and KeyboardKit will automatically adjust the text direction.

`Locale` has `isLeftToRight` and `isRightToLeft` properties that tells you if a locale is left-to-right or right-to-left.

``KeyboardLocale`` also has handy ``KeyboardLocale/allLtr`` and ``KeyboardLocale/allRtl`` collections and collection filters.

However, if you want to use one single RTL locale, you can however adjust the keyboard extension's `Info.plist`:

* Set `PrefersRightToLeft` to `1`.
* Set `PrimaryLanguage` to the language code of your primary RTL language, e.g. `fa` for Perian (Farsi).

Just be aware that setting the primary language like this may affect external keyboard key mappings.



## How to translate localized content

Each ``KeyboardLocale`` has a localized strings file in `Resources/<id>.lproj`. 

Localized strings can be translated using the ``KKL10n`` enum. For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``KeyboardLocale`` or `Locale`, you can use any of the various `text(for:)` functions:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, You can get a flag for a locale, using the ``KeyboardLocale/flag`` property. You can also use ``KeyboardContext`` ``KeyboardContext/localePresentationLocale`` to set how locales are displayed.



## How to add a new keyboard locale

Since each ``KeyboardLocale`` is hard-coded into the library, new keyboard locales must be hard-coded in the same way.

You can add new keyboard locales by following these steps:

* Fork the KeyboardKit project and create a feature branch.
* Create a new ``KeyboardLocale`` case and define all required properties.
* Create a new `Resources/<id>.lproj` folder for the new locale.
* Make sure that linting works and that all tests pass, then push your changes to your fork. 
* Create a pull request from your specific fork and feature branch.

In the PR, please provide any additional information that is needed to correctly support the locale.


### Primary button types

To properly translate the various primary button types, you can find them in the following places:

* `done` - Apple Calendar, when adding new activity and tapping place or video call.
* `go` - Mobile Safari, when typing a url.  
* `join` - System Settings, when joining a wi-fi network with password.
* `next` - System Settings, when joining an enterprise wi-fi network with uid/pwd.
* `ok` - A standard OK button.
* `return` - Apple Notes, when typing.
* `search` - Mobile Safari, when typing in the google.com search bar.
* `send` - Some chat apps (WeChat, QQ), when typing in a chat text field.
* `space` - The text that is displayed on the space bar.   


### Emojis

Emojis can be localized as well, but that is a massive undertaking. Have a look at the English localization file for an example.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional localization capabilities.

KeyboardKit Pro unlocks localized ``InputSet``s, ``KeyboardLayoutProvider``s and ``CalloutActionProvider``s for each ``KeyboardLocale`` that the license contains.

This means that KeyboardKit Pro can create a fully localized ``SystemKeyboard`` by just registering a license key.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

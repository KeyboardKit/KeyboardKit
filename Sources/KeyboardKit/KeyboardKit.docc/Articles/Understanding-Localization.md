# Understanding Localization

This article describes the KeyboardKit localization engine.

A flexible localization engine is an important part of a software keyboard, which should cater to the needs of the locales it supports.

In KeyboardKit, the ``KeyboardLocale`` enum defines keyboard locales, where each locale refers to a native `Locale` and has localized strings and assets. KeyboardKit also extends `Locale` with a bunch of additional capabilities.

[KeyboardKit Pro][Pro] unlocks localized services for all the locales in your license when you register a valid license key. Information about Pro features can be found at the end of this article.



## Supported locales

KeyboardKit supports 61 keyboard-specific ``KeyboardLocale``s:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 <br />

🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 <br />

🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 <br />

🇺🇿 <br />

Each keyboard locale refers to a native `Locale` and has additional keyboard-specific information, as well as localized assets and strings that can be translated with the ``KKL10n`` enum.



## Locale extensions

KeyboardKit extends the native `Locale` type with more functionality.

### Direction info

KeyboardKit lets you get the line and character direction of a locale:

```swift
KeyboardLocale.english.locale.isLeftToRight     // true
KeyboardLocale.english.locale.isRightToLeft     // false
KeyboardLocale.arabic.locale.isRightToLeft      // true
KeyboardLocale.arabic.locale.lineDirection      // .rightToLeft

KeyboardLocale.spanish.locale.isTopToBottom     // false
KeyboardLocale.german.locale.isBottomToTop      // false
```

### Flag info

KeyboardKit lets you get the flag of a locale:

```swift
KeyboardLocale.english.locale.flag      // 🇺🇸
KeyboardLocale.english_uk.locale.flag   // 🇬🇧
KeyboardLocale.swedish.flag             // 🇸🇪
```

### Localized name

KeyboardKit lets you get and use the localized names of a locale:

```swift
let english = KeyboardLocale.english
let swedish = KeyboardLocale.swedish

english.locale.localizedName     // English (United States)
swedish.locale.localizedName(
    in: english.locale)          // Swedish (Sweden)
swedish.locale.localizedName(
    in: swedish.locale)          // Svenska (Sverige)

english.locale.localizedLanguageName    // English
swedish.locale.localizedLanguageName(
    in: english.locale)                 // Swedish (Sweden)
swedish.locale.localizedLanguageName(
    in: swedish.locale)                 // Svenska (Sverige)
```

### Sorting

KeyboardKit also provide convenient Locale collection sorted extensions.



## How to get the current keyboard locale 

You can get the current keyboard locale via ``KeyboardInputViewController/keyboardContext``.``KeyboardContext/locale`` and all the currently available locales via ``KeyboardInputViewController/keyboardContext``.``KeyboardContext/locales``.

Note that these properties return raw `Locale` values, since a keyboard extension is not limited to the ``KeyboardLocale`` model. You can use the optional ``KeyboardContext/keyboardLocale`` if you want the keyboard-specific locale.



## How to change keyboard locale 

You can change the keyboard locale by setting ``KeyboardInputViewController/keyboardContext``.``KeyboardContext/locale`` to a new locale, or use the convenience functions that support both `Locale` and ``KeyboardLocale``. 

Setting the locale will update the controller's `primaryLanguage`, which controls things like spellchecking and text direction. It will also set the display name in the system keyboard switcher.

> Note: The `primaryLanguage` property always returns `nil`, even after being set.

You can set the available locales for a keyboard extension by setting ``KeyboardInputViewController/keyboardContext``.``KeyboardContext/locales`` to the locales you want to use. This makes it possible to switch locale using ``KeyboardContext/selectNextLocale()`` or a ``LocaleContextMenu``.



## How to use LTR and RTL locales

KeyboardKit supports LTR (Left-To-Right) and RTL (Right-To-Left) locales.

You don't need to configure your keyboard to support RTL. Just change the keyboard locale as explained above, and KeyboardKit will automatically adjust the text direction.

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

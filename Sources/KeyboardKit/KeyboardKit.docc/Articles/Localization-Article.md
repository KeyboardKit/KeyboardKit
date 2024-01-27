# Localization

This article describes the KeyboardKit localization engine.

Flexible localization support is an important part of a software keyboard, and should be able to localize the entire keyboard.

In KeyboardKit, ``KeyboardLocale`` defines keyboard-specific languages, where each has localized strings, assets, and locale-specific information. 

KeyboardKit also extends the native **Locale** type with a bunch of additional capabilities.

[KeyboardKit Pro][Pro] unlocks localized keyboards and services for all the locales in your license. Information about Pro features can be found at the end of this article.



## Supported locales

KeyboardKit supports 63 keyboard-specific ``KeyboardLocale``s:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🏳️ 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 <br />

Each locale refers to a native **Locale** and has additional information and propeties, as well as localized assets and strings that can be translated with the ``KKL10n`` enum.



## Keyboard Locale

The ``KeyboardLocale`` enum defines all supported locales, for instance:

```swift
KeyboardLocale.english
KeyboardLocale.swedish
KeyboardLocale.persian
...
```

The locale has a ``KeyboardLocale/locale`` property that returns the native locale, a ``KeyboardLocale/matches(_:)`` function that lets you search, collection modifiers, behaviors, flags, sorting, and much, much more.

For instance, you can get the flag like this:

```swift
KeyboardLocale.english.flag    // 🇺🇸
KeyboardLocale.swedish.flag    // 🇸🇪
KeyboardLocale.persian.flag    // 🇮🇷
```

You can translate locales between eachother, to simplify localizing language pickers in your app.


## Locale

KeyboardKit extends the native **Locale** type with more functionality.

For instance, you can get the line and character direction of a locale like this:

```swift
let english = KeyboardLocale.english.locale
let persian = KeyboardLocale.persian.locale
let swedish = KeyboardLocale.swedish.locale

english.isLeftToRight  // true
english.isTopToBottom  // false
persian.isRightToLeft  // true
persian.isTopToBottom  // false

english.lineDirection  // .leftToRight
persian.lineDirection  // .rightToLeft
english.characterDirection  // .topToBottom
persian.characterDirection  // .topToBottom
```

You can also get the localized names of a locale, for its own language and in others:

```swift
english.localizedName              // English (United States)
swedish.localizedName(in: english) // Swedish (Sweden)
swedish.localizedName(in: swedish) // Svenska (Sverige)
```

KeyboardKit also provide convenient collection sorting and pattern matching extensions.



## How to get the current keyboard locale 

You can get the current locale and all available locales with ``KeyboardContext``'s ``KeyboardContext/locale`` and ``KeyboardContext/locales``.

These properties return raw **Locale** values, since a keyboard isn't limited to the ``KeyboardLocale`` model. The context also has optional, ``KeyboardLocale``-specific variants.



## How to set the current keyboard locale 

You can change the keyboard locale by setting the ``KeyboardContext``'s ``KeyboardContext/locale`` to a new locale, or use the ``KeyboardLocale``-based convenience functions.

If the context ``KeyboardContext/locales`` has multiple values, you can also switch locale using ``KeyboardContext/selectNextLocale()`` or a ``LocaleContextMenu`` that lets the user select a locale.

Setting the locale will update the controller's **primaryLanguage**, which controls things like spellchecking and text direction. It also sets the keyboard locale name in the keyboard switcher.

> Note: The `primaryLanguage` property always returns `nil`, even after being set.



## How to use LTR and RTL locales

KeyboardKit supports LTR (Left-To-Right) and RTL (Right-To-Left) locales.

You don't need to configure your keyboard to support RTL. Just change the keyboard locale as explained above, and KeyboardKit will automatically adjust the text direction.

If you want to use a single RTL locale, you can adjust the keyboard extension **Info.plist**:

* Set **PrefersRightToLeft** to **1**.
* Set **PrimaryLanguage** to the language code of your locale, e.g. **fa** for Perian (Farsi).

Just be aware that setting the primary language may affect external keyboard key mappings.



## How to translate localized content

Each ``KeyboardLocale`` has a localized strings file in **Resources/<id>.lproj**. 

Localized strings can be translated using the ``KKL10n`` enum. For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``KeyboardLocale`` or `Locale`, you can use any of the various **text(for:)** functions:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, you can get a flag for a locale, using the ``KeyboardLocale/flag`` property. You can also use ``KeyboardContext`` ``KeyboardContext/localePresentationLocale`` to set how locales are displayed.



## How to add a new keyboard locale

For information on how to add new keyboard locales, see **Instructions.md** in **Resources**.



## Views

KeyboardKit has a ``LocaleContextMenu`` that can be used to pick locales:

![LocaleContextMenu](localecontextmenu-350.jpg)

This context menu can be applied to any view, and is used by ``SystemKeyboard`` to apply it to any ``KeyboardAction/nextLocale`` action.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks ``InputSet``s, ``KeyboardLayoutProvider``s and ``CalloutActionProvider``s for every ``KeyboardLocale`` in the license.

This means that KeyboardKit Pro can create fully localized ``SystemKeyboard`` for all locales.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

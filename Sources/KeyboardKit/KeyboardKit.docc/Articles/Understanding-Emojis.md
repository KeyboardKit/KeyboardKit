# Understanding Emojis

This article describes the KeyboardKit emoji engine.

KeyboardKit provides you with an ``Emoji`` type that has unicode and emoji information, an emoji localization engine, etc.

[KeyboardKit Pro][Pro] unlocks an emoji keyboard, as well as emoji categories, keyboards, skintones, version information, etc. Information about Pro features can be found at the end of this article.



## Emojis namespace

KeyboardKit has an ``Emojis`` namespace that contains emoji-related types and views. KeyboardKit Pro adds more features to this namespace.

The namespace doesn't contain protocols, open classes or types that are meant to be top-level ones. It's meant to contain types used by top-level types, to make the library easier to overview.



## Emoji

KeyboardKit has an ``Emoji`` struct that lets you work with emojis in a more structured way:

```swift
let emoji = Emoji("😀")
```

This type provides you with a bunch of information, such as the emoji's unique unicode-based identifier and name, localized name etc.:

```swift
let emoji = Emoji("😀")
emoji.unicodeIdentifier // \\N{GRINNING FACE}
emoji.unicodeName // Grinning Face
```

Emojis can be localized with the localization files found in the `Sources/Resources` folder. Emojis that lack a localized name will use ``Emoji/unicodeName`` as a fallback.

```swift
let emoji = Emoji("😀")
emoji.localizedName(for: .english) // Grinning Face
emoji.localizedName(for: .swedish) // Leende Ansikte
```

To localize emojis for a locale, add translations to the correct `Localizable.strings` file on this format:

```
/* [😀] */ "Emoji.GrinningFace" = "Grinning Face";
/* [😃] */ "Emoji.SmilingFaceWithOpenMouth" = "Smiling Face with Open Mouth";
```

Emoji localization is a major undertaking and will therefore have to be a community effort.



## String & Character Extensions

KeyboardKit has String and Character extensions to detect emojis, for instance:

```swift
"Hello!".containsEmoji // false
"Hello! 👋".containsEmoji // true
"Hello! 👋".containsOnlyEmojis // false
"👋".containsOnlyEmojis // true
"Hello! 👋😀".emojis // ["👋", "😀"]
"Hello! 👋😀".emojiString // "👋😀"
"🫸🫷".isSingleEmoji // false
"👍".isSingleEmoji // true
```

These extensions make it easier to handle text and inputs, and are used to power more powerful features.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks an emoji keyboard, categories, keyboards, skintones, version info, etc.


### Emoji Keyboard

KeyboardKit Pro unlocks an **EmojiKeyboard** that mimics the native emoji keyboard. 

![Emoji Keyboard](emoji-keyboard-500.jpg)

The keyboard uses a bunch of views that are also unlocked by KeyboardKit Pro, such as the **Emojis.Grid**, as well as titles, menus, etc. You can use these views as standalone components as well. 


### Emoji Categories

KeyboardKit Pro unlocks an **Emojis.Category** enum that defines all available emoji categories and their emojis, for instance:

```swift
Emojis.Category.smileys.emojis    // 😀😃😄😁😆🥹😅😂🤣🥲 ...
Emojis.Category.animals.emojis    // 🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨 ...
```

You can get a list of all available categories like this:

```swift
Emojis.Category.all     // [.frequent, .smileys, .animals, ...]
```

and use these categories to get a list of all available emojis:

```swift
Emoji.all     // 😀😃😄😁😆🥹😅😂🤣🥲 ...
```

Emoji categories are also used to power the **EmojiKeyboard**.


### Emoji Skin tones

KeyboardKit Pro unlocks additional ``Emoji`` extensions to get skin tone information:

```swift
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false
Emoji("👍🏿").neutralSkinToneVariant  // 👍
Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
Emoji("👍").skinToneVariantActions  // The above variants as keyboard actions
```

Skin tones will also be used as secondary callout actions, which means that long pressing an emoji with skintones in an emoji keyboard will show an action callout. 

> Note: Skin tone support for emojis with multiple skin tone components are currently not supported, such as two persons kissing.


### Emoji Versions

KeyboardKit Pro unlocks an **EmojiVersion** type that defines emoji versions, platform availability and included emojis, for instance:

```swift
let version = EmojiVersion.v15
version.version  // 15.0
version.iOS      // 16.4
version.macOS    // 13.3
version.tvOS     // 16.4
version.watchOS  // 9.4
```

You can also get the emoji version included in a certain platform version, for instance:

```swift
let version = EmojiVersion(iOS: 15.4)
version.version  // 14.0
```

A version specifies the emojis introduced in that version, later and older versions and emojis that were introduced in later versions:

```swift
let version = EmojiVersion.v14
version.emojis            // 🫠🫢🫣🫡🫥🫤🥹...
version.laterVersions     // [.v15]
version.olderVersions     // []
version.unavailableEmojis // 🫨🫸🫷🪿🫎🪼🫏🪽...
```

This can be used to filter out unavailable emojis from the various categories, which lets the emoji keyboard only list available emojis.


### Most recent emojis

[KeyboardKit Pro][Pro] unlocks an **Emojis.MostRecentProvider** and will also replace the ``StandardKeyboardActionHandler`` with a **ProKeyboardActionHandler** that uses this provider to automatically registers emojis as you use them.

> Important: If you have a custom action handler, make sure to inherit ProKeyboardActionHandler instead of StandardKeyboardActionHandler when you switch over to KeyboardKit Pro, otherwise your keyboard won't register the most recently used emojis.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

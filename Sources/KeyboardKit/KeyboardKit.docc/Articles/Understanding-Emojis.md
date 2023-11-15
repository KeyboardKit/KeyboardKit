# Understanding Emojis

This article describes the KeyboardKit emoji engine.

KeyboardKit provides you with an ``Emoji`` type that provides many emoji-related features.

[KeyboardKit Pro][Pro] unlocks an emoji keyboard, as well as categories, keyboards, skintones, version information, etc. Information about Pro features can be found at the end of this article.



## Emoji

KeyboardKit has an ``Emoji`` struct that lets you work with emojis in a more structured way:

```swift
let emoji = Emoji("😀")
```

This type can be used to create actions with the ``KeyboardAction/emoji(_:)-swift.enum.case`` action type.



## String & Character Extensions

KeyboardKit has String and Character extensions that can be used to detect and handle emojis, for instance:

```swift
"Hello!".containsEmoji          // false
"Hello! 👋".containsEmoji       // true
"Hello! 👋".containsOnlyEmojis  // false
"👋".containsOnlyEmojis         // true
"Hello! 👋😀".emojis            // ["👋", "😀"]
"Hello! 👋😀".emojiString       // "👋😀"
"🫸🫷".isSingleEmoji            // false
"👍".isSingleEmoji              // true
```

These extensions are used to power many of the emoji-specific features in the library, but can be used as stand-alone features as well.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks an emoji keyboard, categories, keyboards, skintones, version information, etc.


### Emoji Keyboard

KeyboardKit Pro unlocks an **EmojiKeyboard** that mimics the native emoji keyboard. 

![Emoji Keyboard](emoji-keyboard-500.jpg)

The keyboard uses a bunch of views that are also unlocked by KeyboardKit Pro, such as **Emoji.KeyboardGrid**, titles, menus, etc. You can use these views as standalone components as well.


### Unicode information

KeyboardKit Pro unlocks unique unicode-based identifiers and names for all emojis:

```swift
let emoji = Emoji("😀")
emoji.unicodeIdentifier // \\N{GRINNING FACE}
emoji.unicodeName // Grinning Face
```

This information can be used to identify and localize emojis.


### Localized names

KeyboardKit Pro unlocks localized names for all emojis:

```swift
let emoji = Emoji("😀")
emoji.localizedName(for: .english) // Grinning Face
emoji.localizedName(for: .swedish) // Leende Ansikte
```

Emojis can be localized with the localization files found in `/Sources/Resources`.

Emojis are currently only localized in English. Emoji localization is a major undertaking and will therefore have to be a community effort. 

Feel free to contribute localizations for your language.


### Categories

KeyboardKit Pro unlocks an **Emoji.Category** enum that defines all emoji categories and their emojis, for instance:

```swift
Emoji.Category.smileys.emojis    // 😀😃😄😁😆🥹😅😂🤣🥲 ...
Emoji.Category.animals.emojis    // 🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨 ...
```

You can get a list of all available categories like this:

```swift
Emojis.Category.all     // [.frequent, .smileys, .animals, ...]
```

This information is used to provide a list of all available emojis:

```swift
Emoji.all     // 😀😃😄😁😆🥹😅😂🤣🥲 ...
```

Emoji categories are also used to power the **EmojiKeyboard**.


### Skin Tones

KeyboardKit Pro unlocks additional ``Emoji`` skin tone information:

```swift
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false
Emoji("👍🏿").neutralSkinToneVariant  // 👍
Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
Emoji("👍").skinToneVariantActions  // The above variants as keyboard actions
```

Skin tones will automatically be used as secondary callout actions, which means that long pressing an emoji with skintones in an emoji keyboard will show an action callout. 

> Note: Skin tone support for emojis with multiple skin tone components are currently not supported, such as two persons kissing.


### Emoji Versions

KeyboardKit Pro unlocks an **Emoji.Version** type that defines emoji versions, platform availability and included emojis.

To get the latest available version for the current runtime, you can use **.current**:

```swift
let version = Emoji.Version.current
version.version  // 15.0
version.iOS      // 16.4
version.macOS    // 13.3
version.tvOS     // 16.4
version.watchOS  // 9.4
```

You can also request specific versions, for instance:

```swift
let version = Emoji.Version.v15
version.version  // 15.0
version.iOS      // 16.4
version.macOS    // 13.3
version.tvOS     // 16.4
version.watchOS  // 9.4
```

You can also get the latest version for a certain OS version, for instance:

```swift
let version = Emoji.Version(iOS: 15.4)
version.version  // 14.0
```

An emoji version specifies the emojis introduced in that version, later and older versions and emojis that were introduced in later versions:

```swift
let version = Emoji.Version.v14
version.emojis            // 🫠🫢🫣🫡🫥🫤🥹...
version.laterVersions     // [.v15]
version.olderVersions     // []
version.unavailableEmojis // 🫨🫸🫷🪿🫎🪼🫏🪽...
```

This can be used to filter out unavailable emojis from the various categories, which lets the emoji keyboard only list available emojis.


### Most recent emojis

KeyboardKit Pro unlocks an **Emoji.MostRecentProvider** that can be used to register and get the most recently used emojis.

KeyboardKit Pro binds such an instance to **Emoji.frequentEmojiProvider** and injects it into the ``StandardKeyboardActionHandler/emojiRegistrationAction``. This will make the "most recent" emojis category automatically update when you tap emojis in the emoji keyboard.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

# Emojis

This article describes the KeyboardKit emoji engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

KeyboardKit has an ``Emoji`` struct that represents an emoji value, and defines available ``EmojiCategory`` and ``EmojiVersion`` values that let you fetch all available emojis from all available categories and versions.

👑 [KeyboardKit Pro][Pro] unlocks an ``EmojiKeyboard`` that is automatically added to ``SystemKeyboard`` when a valid license is registered. Information about Pro features can be found at the end of this article.



## Emoji Model

The ``Emoji`` struct represents a structured emoji model, that lets you work with emojis and their information in a more structured way:

```swift
let emoji = Emoji("😀")
```

You can use ``Emoji/all`` to get a list of all emojis from all categories available to the current runtime:

```swift
let emojis = Emoji.all   // 😀😃😄😁😆🥹😅😂🤣🥲...
```

You can trigger emoji character insertion by triggering the ``KeyboardAction/emoji(_:)-swift.enum.case`` keyboard action, just like you trigger any other keyboard action.


### Unicode Information

The ``Emoji`` enum has unicode-specific properties that can be used for identity and naming:

```swift
Emoji("👍").unicodeIdentifier   // \\N{THUMBS UP SIGN}
Emoji("👍🏿").unicodeIdentifier   // \\N{THUMBS UP SIGN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-6}
Emoji("🚀").unicodeIdentifier   // \\N{ROCKET}
Emoji("👍").unicodeName         // Thumbs Up Sign
Emoji("👍🏿").unicodeName         // Thumbs Up Sign
Emoji("🚀").unicodeName         // Rocket
```


### Skintone Information

The ``Emoji`` enum has skin tone-specific properties that define skin tone variants for all supported emojis:

```swift
Emoji("👍").hasSkinToneVariants      // true
Emoji("🚀").hasSkinToneVariants      // false
Emoji("👍🏿").neutralSkinToneVariant   // 👍
Emoji("👍").skinToneVariants         // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
Emoji("👍").skinToneVariantActions   // The above variants as keyboard actions
```

Skin tones will automatically be added as secondary actions when using the KeyboardKit Pro emoji keyboard. 

> Note: Skin tone support for emojis with multiple skin tone components are currently not supported, such as two persons kissing.


### Localization Support

The ``Emoji`` enum can be localized in any supported locale that has defined translations:

```swift
let english = Locale(identifier: "en-US")
let swedish = Locale(identifier: "sv")

Emoji("😀").localizedName                  // Grinning Face
Emoji("😀").localizedName(for: .english)   // Grinning Face
Emoji("😀").localizedName(for: .swedish)   // Leende Ansikte
```

Take a look at `Resources/en.lproj/Localizable.strings` to see how you can localize emojis for more keyboard locales.



## String & Character Extensions

There are String & Character extensions that can be used to detect and handle emojis:

```swift
"Hello!".containsEmoji           // false
"Hello! 👋".containsEmoji        // true
"Hello! 👋".containsOnlyEmojis   // false
"👋".containsOnlyEmojis          // true
"Hello! 👋😀".emojis             // ["👋", "😀"]
"Hello! 👋😀".emojiString        // "👋😀"
"🫸🫷".isSingleEmoji             // false
"👍".isSingleEmoji               // true
```



## Emoji Categories

The ``EmojiCategory`` enum defines all available emoji categories and their emojis:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
try EmojiCategory.animalsAndNature.emojis  // 🐶🐱🐭...
```

You can use ``EmojiCategory/all`` to get a list of all available categories, in the native, default sort order:

```swift
EmojiCategory.all      // [.frequent, .smileyAndPeople, ...]
```

``EmojiCategory`` uses ``EmojiVersion`` to filter out emojis that are unavailable to the current runtime, to only include available emojis.



## Emoji Versions

The ``EmojiVersion`` enum defines all available emoji versions and their emojis and supported platforms:

```swift
let version = EmojiVersion.v15

version.emojis          // 🫨🫸🫷🪿🫎🪼🫏🪽🪻🫛🫚🪇🪈🪮🪭🩷🩵🩶🪯🛜...

version.version         // 15.0
version.iOS             // 16.4
version.macOS           // 13.3
version.tvOS            // 16.4
version.watchOS         // 9.4

version.laterVersions   // []
version.olderVersions   // [.v14, .v13_1, .v13, .v12_1, ...]
```

All this information is used to resolve which of all available emojis, that are unavailable for a certain emoji version:

```swift
let version = EmojiVersion.v14

version.unavailableEmojis // 🫨🫸🫷🪿🫎🪼🫏🪽...
```

``EmojiCategory`` uses ``EmojiVersion`` to filter out emojis that are unavailable to the current runtime, to only include available emojis.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] adds more types to ``Emoji`` and unlocks an ``EmojiKeyboard`` that is automatically added to the ``SystemKeyboard`` when a valid license is registered.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

### Views

@TabNavigator {
    
    @Tab("EmojiKeyboard") {
        
        KeyboardKit Pro unlocks an ``EmojiKeyboard`` that mimics the native emoji keyboard, with support for categories, skin tones, etc.
        
        ![Emoji Keyboard](emojikeyboard-350.jpg)
        
        The view can be styled with an ``EmojiKeyboardStyle``, which can be applied with the ``SwiftUI/View/emojiKeyboardStyle(_:)`` view modifier.
        }
}
        
See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.

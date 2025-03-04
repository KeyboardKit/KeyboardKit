# Emojis

This article describes the KeyboardKit emoji engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit has an ``Emoji`` struct that represents an plain emoji value, and defines ``EmojiCategory`` and ``EmojiVersion`` values that let you fetch all available emojis from all available categories and versions.

👑 [KeyboardKit Pro][Pro] unlocks an ``EmojiKeyboard`` that's used by ``KeyboardView`` when a valid license is registered. It also unlocks an ``Emoji``.``Emoji/ColonSearch`` search engine.  Information about Pro features can be found further down.

> Important: The ``EmojiKeyboard`` uses high-resolution emojis on iPad, which consumes a lot of memory when scrolling through categories. Apply an ``Emoji/KeyboardStyle/optimized(for:)`` style with ``SwiftUICore/View/emojiKeyboardStyle(_:)`` if your keyboard uses memory-intense tools. Check out the <doc:Developer-Memory-Management> article for more information about memory management in keyboard extensions.



## Emojis

The ``Emoji`` struct represents a structured emoji model that lets you work with emojis and their information in a more structured way:

```swift
let emoji = Emoji("😀")
```

You can trigger emoji character insertion by triggering the ``KeyboardAction/emoji(_:)-swift.enum.case`` keyboard action, just like you trigger any other keyboard action.



## Emoji Categories

The ``EmojiCategory`` enum defines all available emoji categories and their emojis:

```swift
EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
EmojiCategory.animalsAndNature.emojis  // 🐶🐱🐭...
```

``EmojiCategory`` uses ``EmojiVersion`` to filter out emojis that are unavailable to the current runtime, to only include available emojis.



## Emoji Versions

The ``EmojiVersion`` enum defines all available emoji versions and their emojis and supported platforms:

```swift
let version = EmojiVersion.v15
version.emojis          // 🫨🫸🫷🪿🫎🪼🫏🪽🪻🫛🫚🪇🪈🪮🪭🩷🩵🩶🪯🛜...
version.version         // 15.0
version.iOS             // 16.4
version.olderVersions   // [.v14, .v13_1, .v13, .v12_1, ...]
```

``EmojiCategory`` uses ``EmojiVersion`` to filter out emojis that are unavailable to the current runtime, to only include available emojis.



## Unicode Information

The ``Emoji`` enum has unicode-specific properties that can be used for identity and basic, non-localized naming:

```swift
Emoji("👍").unicodeIdentifier   // \\N{THUMBS UP SIGN}
Emoji("👍🏿").unicodeIdentifier   // \\N{THUMBS UP SIGN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-6}
Emoji("👍").unicodeName         // Thumbs Up Sign
```


## Skintone Information

The ``Emoji`` enum has skin tone-specific properties that define skin tone variants for all supported emojis:

```swift
Emoji("👍").hasSkinToneVariants      // true
Emoji("🚀").hasSkinToneVariants      // false
Emoji("👍🏿").neutralSkinToneVariant   // 👍
Emoji("👍").skinToneVariants         // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
```

The ``EmojiKeyboard`` will automatically add skin tones as secondary callout actions to all single-component emojis that have them.



## Localization Support

The ``Emoji`` and ``EmojiCategory`` enums can be localized in any locale that has translations:

```swift
let emoji = Emoji("😀") 
emoji.localizedName                   // Grinning Face
emoji.localizedName(in: .swedish)     // Leende Ansikte

let category = EmojiCategory.animalsAndNature 
category.localizedName                // Animals & Nature
category.localizedName(in: .swedish)  // Djur och natur
```

Take a look at `Resources/en.lproj/Localizable.strings` to see how you can localize emojis for more keyboard locales.



## String & Character Extensions

There are String & Character extensions that can be used to detect and handle emojis, for instance:

```swift
"Hello!".containsEmoji           // false
"Hello! 👋".containsEmoji        // true
"Hello! 👋".containsOnlyEmojis   // false
"Hello! 👋😀".emojis             // ["👋", "😀"]
```


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks an ``EmojiKeyboard`` that is automatically added to the ``KeyboardView`` when a Gold license is registered.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Colon Search

KeyboardKit unlocks an ``Emoji``.``Emoji/ColonSearch`` search engine that makes it possible to search for emojis by starting the current word with a colon. This engine can be used by the local autocomplete service, to add emoji suggestions to the search result.


### Views

@TabNavigator {
    
    @Tab("EmojiKeyboard") {
        
        @Row {
            @Column {
                ![Emoji Keyboard](emojis-emojikeyboard)
            }
            @Column {
                The ``EmojiKeyboard`` mimics a native emoji keyboard. It has support for categories, skin tones, callouts, etc.
                
                The view can be styled with an emoji-specific ``Emoji/KeyboardStyle``, which can be applied with the ``SwiftUICore/View/emojiKeyboardStyle(_:)`` view modifier. Use the builder-based style modifier to generate styles at runtime, based on the keyboard context.
                
                > Note: This view requires a KeyboardKit Pro Gold license.
            }
        }
    }
}

> Important: Since SwiftUI's grid views don't deallocate cells, the emoji keyboard will allocate memory for each new emoji, but never deallocate any allocated memory. This leads to ever increasing memory consumption as your users swipe through categories. Due to this, the ``EmojiKeyboard`` uses an ``Emoji/KeyboardStyle/optimized(for:)`` style on iPhone, to save memory. If your keyboard uses too much base memory, you may however have to use the ``SwiftUICore/View/emojiKeyboardStyle(_:)`` modifier to enforce using an optimized style on all devices. Just apply it to the keyboard view.    

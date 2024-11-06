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

👑 [KeyboardKit Pro][Pro] unlocks an ``EmojiKeyboard`` that's automatically injected into ``KeyboardView`` when a valid license is registered. Information about Pro features can be found further down.

> Important: The ``EmojiKeyboard`` uses high-resolution emojis on iPad, which can consume a lot of memory when scrolling through the emoji categories. Apply an ``Emoji/KeyboardStyle/optimized(for:)`` style with ``SwiftUICore/View/emojiKeyboardStyle(_:)`` if your keyboard uses memory-intense tools, since keyboard extensions are memory capped at ~70 MB.



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

[KeyboardKit Pro][Pro] unlocks an ``EmojiKeyboard`` that is automatically added to the ``KeyboardView`` when a valid license is registered.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("EmojiKeyboard") {
        
        @Row {
            @Column {
                ![Emoji Keyboard](emojikeyboard)
            }
            @Column {
                The ``EmojiKeyboard`` mimics a native emoji keyboard. It has support for categories, skin tones, callouts, etc.
                
                The view can be styled with an emoji-specific ``Emoji/KeyboardStyle``, which can be applied with the ``SwiftUICore/View/emojiKeyboardStyle(_:)`` view modifier. Use the builder-based style modifier to generate styles at runtime, based on the keyboard context.
            }
        }
    }
}


If you don't apply a custom style builder, the style will default to a memory optimized style for iPhones and a standard one for iPads.

This is how you can apply a memory optimized Emoji keyboard style for all device types, to help save memory when rendering emojis:

```swift
YourView(...)
    .emojiKeyboardStyle { context in
        .optimized(for: context)    // This will apply an optimized style regardless of the context.
    }
```

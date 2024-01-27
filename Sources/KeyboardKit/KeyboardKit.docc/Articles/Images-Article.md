# Images

This article describes the KeyboardKit keyboard image engine.

While you can use any native **Image** in your custom keyboards, having access to keyboard-specific images simplifies creating keyboards that look more native.

KeyboardKit provides keyboard-specific image extensions, for both SF Symbols and assets. 



## SF Symbols

KeyboardKit has a bunch of **Image** extensions that resolve to SF Symbols, for instance:.

![SF Symbol Images](images-350.jpg)

These images are prefixed with **keyboard**, to make them easy to find with Xcode autocomplete:

```swift
.keyboard
.keyboardArrowUp
.keyboardArrowDown
.keyboardArrowLeft
.keyboardArrowRight
.keyboardAudioFeedbackEnabled
// ...and so on
```

Since these images are SF Symbols, they will scale well when resized with **.frame** and **.font**. 



## Assets

KeyboardKit also has **Image** extensions that resolve to custom emoji assets, for instance:

![Asset-based Images](images-emojis-350.jpg)

The button image is named **keyboardEmoji**, while categories use a **emojiCategory** builder:

```swift
Image.keyboardEmoji

Image.emojiCategory(.frequent)
Image.emojiCategory(.smileys)
Image.emojiCategory(.animals)
Image.emojiCategory(.food)
Image.emojiCategory(.activities)
Image.emojiCategory(.travels)
Image.emojiCategory(.objects)
Image.emojiCategory(.symbols)
Image.emojiCategory(.flags)
```

Since these images are vectorized PDF assets, they will also scale well when they are resized.

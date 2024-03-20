# Images

This article describes the KeyboardKit keyboard image engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

KeyboardKit provides additional, keyboard-specific images that make it easy to apply a keyboard style that mimics the native style.

👑 [KeyboardKit Pro][Pro] also provides vectorized assets for e.g. ``EmojiCategory``. More information can be found at the end of this article.



## Symbol-based image extensions

KeyboardKit has a bunch of **Image** extensions that resolve to SF Symbols, for instance:

@Row {
    @Column(size:2) {
        ```swift
        .keyboard
        .keyboardArrowUp
        .keyboardArrowDown
        .keyboardArrowLeft
        .keyboardArrowRight
        .keyboardAudioFeedbackEnabled
        // ...and so on
        ```
    }
    @Column {
        ![SF Symbol Images](images.jpg)        
    }
}



These images are prefixed with **keyboard** to make them easy to find, and scale well when resized with the **.frame** and **.font** modifiers.



## 👑 KeyboardKit Pro

KeyboardKit Pro unlocks additional image extensions that resolve to custom, vectorized assets for certain parts of the keyboard.


### Emojis

KeyboardKit Pro unlocks additional **Image** extensions that resolve to vectorized assets for the emoji key and every ``EmojiCategory``.

@Row {
    @Column(size:2) {
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
    }
    @Column {
        ![Asset-based Images](images-emojis.jpg)        
    }
}

Since these images are vectorized PDF assets, they will also scale well when they are resized.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

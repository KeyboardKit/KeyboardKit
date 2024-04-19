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

👑 [KeyboardKit Pro][Pro] provides vectorized assets for e.g. ``EmojiCategory``. Information about Pro features can be found at the end of this article.



## Symbol-based image extensions

KeyboardKit has additional images that aim to match native iOS system images, for instance ``SwiftUI/Image/keyboard``. See the ``SwiftUI/Image`` extension file for a complete list of images that are provided by the library.

@Row {
    @Column {}
    @Column(size: 2) {
        ![SF Symbol Images](images)
    }
    @Column {}
}

These images are prefixed with **keyboard** to make them easy to find, and scale well when resized with the **.frame** and **.font** modifiers.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional ``SwiftUI/Image`` extensions that resolve to custom, vectorized image assets for certain parts of the keyboard.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Emojis

KeyboardKit Pro unlocks vectorized assets for the emoji key and all ``EmojiCategory``s, for instance ``SwiftUI/Image/keyboardEmoji`` and ``SwiftUI/Image/emojiCategory(_:)``:

@Row {
    @Column {}
    @Column(size: 2) {
        ![Asset-based Images](images-emojis)
    }
    @Column {}
}

Since these images are vectorized, they scale well when they are resized.

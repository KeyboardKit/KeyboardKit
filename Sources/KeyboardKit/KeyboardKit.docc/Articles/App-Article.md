# App Utilities

This article describes the KeyboardKit app-specific utilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

KeyboardKit provides utility types for the main app target of a keyboard app. It's a new namespace that for now only contains a home screen template.

👑 [KeyboardKit Pro][Pro] unlocks app views for the main app target. Information about Pro features can be found at the end of this article.



## KeyboardApp namespace

KeyboardKit has a ``KeyboardApp`` namespace that contains app-related types, that are meant to be used in the main app. It currently only contains utilities when it's part of a KeyboardKit Pro build.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks views in the ``KeyboardApp`` namespace, that let you quickly add keyboard-related features to your main app:

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("HomeScreen") {
        
        KeyboardKit Pro unlocks a ``KeyboardApp/HomeScreen`` that can be used as the home screen of a keyboard app. It renders an app icon header, then adds a keyboard status section that can be surrounded by a custom top and bottom content.
    
        @Row {
            @Column {}
            @Column {
                ![Keyboard App Home Screen](keyboardapp-homescreen)
            }
            @Column {}
        }
        
        This screen can be styled with the ``SwiftUI/View/keyboardStateLabelStyle(_:)`` modifier, to style things like the icon and the status labels.
    }
}

See the <doc:Styling-Article> article for more information about KeyboardKit view styling.

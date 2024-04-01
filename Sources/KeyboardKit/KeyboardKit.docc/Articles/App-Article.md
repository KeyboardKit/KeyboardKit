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

KeyboardKit has a ``KeyboardApp`` namespace that contains app-related types. For now, it only has nested types when it is a part of a KeyboardKit Pro build.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks views that let you quickly get the main app up and running.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("KeyboardApp.HomeScreen") {
        
        KeyboardKit Pro unlocks a ``KeyboardApp/HomeScreen`` that can be used as the home screen of a keyboard app's main app. It will by default r  render an app icon header, a custom top content, a keyboard status section, and a custom bottom content.
    
        @Row {
            @Column {}
            @Column {
                ![Keyboard App Home Screen](keyboardapp_homescreen.jpg)
            }
            @Column {}
        }
        
        This screen can be styled with the ``SwiftUI/View/keyboardStateLabelStyle(_:)`` modifier, to change things like the icon and style of the status label. It automatically links to System Settings, where the user can enable the keyboard and Full Access.
    }
}

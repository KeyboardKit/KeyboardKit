# Host Application

This article describes how KeyboardKit Pro can identify and use the host application.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit lets you get the bundle ID of the host application that is using the keyboard. This may be of interest for many reasons, e.g. to vary the style or functionality of the keyboard based on the currently active app.

👑 [KeyboardKit Pro][Pro] unlocks an additional ``KeyboardHostApplication`` type that defines many common apps and makes it easier to identify and navigate to specific apps. This lets you open the main app to perform a task, then return to the keyboard. 


## Host Application Bundle Identifier

``KeyboardInputViewController`` has a ``KeyboardInputViewController/hostApplicationBundleId`` property that resolves the bundle identifier for the host application that is currently using the keyboard.

The controller automatically syncs the ``KeyboardInputViewController/hostApplicationBundleId`` to the ``KeyboardContext``. Since you shouldn't pass around the controller, you can instead use the main ``Keyboard/State/keyboardContext``'s ``KeyboardContext/hostApplicationBundleId``.


## Host Application

KeyboardKit Pro unlocks ways to identify specific apps, using a ``KeyboardHostApplication`` type that defines many popular apps.

KeyboardKit Pro adds ``KeyboardHostApplicationProvider/hostApplication`` property to the ``KeyboardContext``. which tries to map ``KeyboardInputViewController/hostApplicationBundleId`` to any of the known host applications.

Once you have a ``KeyboardHostApplication`` instance, you can get additional information about the app, and open it with any of the ``KeyboardHostApplication/openWithAction(_:)`` or ``KeyboardHostApplication/openWithActionHandler(_:)`` functions.


## Known Host Applications

KeyboardKit Pro can currently identify the following applications:

Amazon Prime, App Store, Apple Calendar, Apple Clock, Apple FaceTime, Apple Files, Apple Health, Apple Maps, Apple Messages, Apple Music, Apple Notes, Apple Numbers, Apple Pages, Apple Photos, Apple Podcasts, Apple Reminders, Apple Settings, Apple Shortcuts, Apple Translate, Apple TV, Apple Weather, Blue Sky, Brave, Bolt, ChatGPT, Discord, Disney+, Facebook, Gmail, Goodnotes, Google Assistant, Google Calendar, Google Chat, Google Chrome, Google Docs, Google Drive, Google Home, Google Maps, Instagram, Ivory, KeyboardKit Demo, LinkedIn, Meetup, Messenger, Microsoft OneDrive, Netflix, Signal, Slack, Snapchat, Spotify, Telegram, Trello, Twitch, X (Twitter), WhatsApp, Uber, YouTube

Don't hesistate to reach out if you need to support more apps.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

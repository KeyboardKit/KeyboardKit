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

The ``KeyboardInputViewController`` has a ``KeyboardInputViewController/hostApplicationBundleId`` property that resolves the bundle ID of the app that is currently using the keyboard.

The controller will automatically sync this property to ``KeyboardContext``'s auto-persisted ``KeyboardContext/hostApplicationBundleId`` property, which can be used by your main app target to see in which app your keyboard was last used.

You can use the context's' ``KeyboardContext/hostApplicationBundleIdSyncDate`` to check when the ID was last synced, to see if it's still relevant. You can manually reset the ``KeyboardContext/hostApplicationBundleId`` value if you know that it's not, e.g. if the app launched without a deep link.


## Host Application

KeyboardKit Pro unlocks ways to identify specific apps, using a ``KeyboardHostApplication`` type that defines many popular apps.

KeyboardKit Pro adds a ``KeyboardHostApplicationProvider/hostApplication`` property to the ``KeyboardContext``, which maps the ``KeyboardInputViewController/hostApplicationBundleId`` to any of the following known applications:

Amazon Prime, App Store, Apple Calendar, Apple Clock, Apple FaceTime, Apple Files, Apple Health, Apple Maps, Apple Messages, Apple Music, Apple Notes, Apple Numbers, Apple Pages, Apple Photos, Apple Podcasts, Apple Reminders, Apple Settings, Apple Shortcuts, Apple Translate, Apple TV, Apple Weather, Blue Sky, Brave, Bolt, ChatGPT, Discord, Disney+, Facebook, Gmail, Goodnotes, Google Assistant, Google Calendar, Google Chat, Google Chrome, Google Docs, Google Drive, Google Home, Google Maps, Instagram, Ivory, KeyboardKit Demo, LinkedIn, Meetup, Messenger, Microsoft OneDrive, Netflix, Signal, Slack, Snapchat, Spotify, Telegram, Trello, Twitch, X (Twitter), WhatsApp, Uber, YouTube

Once you have resolved a ``KeyboardHostApplication``, you can open it with ``KeyboardHostApplication/openWithAction(_:)`` or ``KeyboardHostApplication/openWithActionHandler(_:)`` and access additional information about the app from the app value.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

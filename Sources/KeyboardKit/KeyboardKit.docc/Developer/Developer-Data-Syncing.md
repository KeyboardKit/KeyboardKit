# Data Syncing

This guide describes how to sync data between an app and its keyboard extension.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

When building a keyboard app, it's important to be able to sync data between the main app and its keyboard extension, for instance if the app is has screens to manage keyboard settings, which should then be applied to the keyboard.

KeyboardKit makes it easy to set up automatic data sync, by setting up your app and keyboard extension with a ``KeyboardApp``, as is described in the <doc:Getting-Started-Article> guide. All you have to do is to create an App Group and apply it to your app and keyboard extension.


## How to...

### ...set up an App Group for your app

@Row {
    @Column {
        ![A screenshot of the Developer Portal](developer-app-groups)
    }
    @Column {
        You must first create an App Group in the Apple Developer Portal, under Certificates, Identifiers & Profiles.
        
        The App Group should start with "group." followed by your app's bundle ID. For instance, the KeyboardKit demo application uses "group.com.keyboardkit.demo" as App Group identifier.
        
        > Note: macOS App Groups must start with the Team ID instead of "group.". This may be a temporary bug or an unintended change, since having duplicate groups is very cumbersome.
    }
}

### ...link the App Group to the app

@Row {
    @Column {
        After creating the App Group, you must link it to your app and its keyboard extension. This is done under "Signing & Capabilites".
        
        It's *imperative* that you enable the App Group for all targets that should share data, otherwise a target without the group will not be able to read from or write to the shared data store.
    }
    @Column {
        ![A screenshot of how to enable App Groups](developer-app-group-enable)
    }
}
    
### ...set up KeyboardKit to use the App Group

You can easily set up KeyboardKit to use the App Group to sync data, by defining an ``KeyboardApp/appGroupId`` in your ``KeyboardApp`` value, then use that value to set up KeyboardKit as described in the <doc:Getting-Started-Article> guide.

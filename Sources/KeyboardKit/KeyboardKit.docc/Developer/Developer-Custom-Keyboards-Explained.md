# Custom Keyboards Explained

This article describes iOS custom keyboards and how they work.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}


A custom iOS keyboard (or a keyboard extension) is an app extension that you ship together with your app. It can replace the system keyboard in any app that allows typing, by using the bottom-leading 🌐 key.

Keyboard extensions are the only apps that can be used directly with other apps in iOS, and are as such unique ways to let people use your app and its features within other apps.


## How do I create a custom keyboard?

You can add a custom keyboard to any iOS app, from Xcode's "File > New > Target..." menu option. This will add a keyboard extension to your app and make it possible to switch to that keyboard while typing in any app.

The keyboard will by default show some boilerplate content. You can use KeyboardKit to easily replace this content with a complete keyboard view, as described in the <doc:Getting-Started-Article> guide.  


## What can a custom keyboard do?

A custom keyboard can render any user interface, and can resize the keyboard area to fit its content. This means that the keyboard can be taller or shorter than the native keyboard and show any content that you want.

Custom keyboards use a *document proxy* to communicate with the currently active app. The proxy can be used to read and modify the document text, move the text input cursor, etc.

A custom keyboard can use these capabilities to provide custom autocomplete & spell-checking, more sophisticated text analysis, AI-based features, etc. The possibilities are endless, but Apple's native APIs are unfortunately very limited.


## What can a custom keyboard not do?

Apple's native keyboard APIs are very limited, which is why KeyboardKit extends them with additional capabilities and more features, to make it a lot easier to create amazing keyboard experiences.

However, some things are just not possible. For instance, a custom keyboard can’t draw outside its bounds and must render within the keyboard frame. Custom keyboards are also memory capped at ~70 MB, which means that you can’t allocate that much memory.

Keyboard extensions must also open their main app to perform certain actions, such as accessing the microphone to perform dictation, and must ask the user to enable Full Access to be able to access certain system tools, make network calls, etc.


## Further Reading

See the [Apple App Extension Programming Guide][Article] for a thorough explanation of the custom keyboard model, and its capabilities. Note that while Apple’s native APIs are very limited, KeyboardKit extends these APIs with many more features.

KeyboardKit is open-source and completely free to use. With over 1,5k stars on GitHub, it's a popular open-source SDK for creating iOS keyboards. It's used by enterprises, smaller companies, startups, universities and indies, in many [innovative projects](https://keyboardkit.com/case-studies).


[Article]: https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/CustomKeyboard.html

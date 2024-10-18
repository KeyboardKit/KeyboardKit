# AI Support

This article describes the KeyboardKit AI support capabilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

Apple's native keyboard APIs lack many features that are needed by popular AI-based features, for instance to read an entire document to perform tasks like spellchecking & proofreading, or to let users type text prompts directly within the keyboard.

Apple's native text document proxy will not return all the text within the document, and may cut off the available text at any time. Users also can't type in a text field within the keyboard, since the text is always sent to the main app.

👑 [KeyboardKit Pro][Pro] unlocks these capabilities to make it possible to read the full document and type in a text field within the keyboard.



## 👑 KeyboardKit Pro

### Full Document Reader

[KeyboardKit Pro][Pro] unlocks ways to read **all** text from a text field, using the ``UIKit/UITextDocumentProxy/fullDocumentContext(config:)`` proxy extensions that will read the full document content instead of just returning the text closest to the input cursor.

By reading the full text, you can pass in more information to your AI model or ChatGPT-powered functionality, and make your AI-based features a lot more capable.

See the <doc:Proxy-Article> article for more information.


### Text Input Support

[KeyboardKit Pro][Pro] unlocks ways to let users type within a keyboard extension, by routing text input from the main app to text fields within the keyboard extension, without the need for any additional code.

KeyboardKit Pro has a ``KeyboardTextField`` that handles text routing automatically, as well as a multi-line ``KeyboardTextView``. You can just add these components to your keyboard and use them like regular text fields.

This lets you provide AI-based features that require user input in your keyboard, such as generating custom images with DALL·E, asking questions to an AI like ChatGPT, etc.

See the <doc:Text-Input-Article> article for more information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

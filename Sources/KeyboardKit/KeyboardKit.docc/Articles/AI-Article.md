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

[KeyboardKit Pro][Pro] provides additional functionality are often needed by AI-based keyboards.

For instance, AI-based keyboards may need to read the entire document to perform tasks like spellchecking and proofreading, and also let users type within the keyboard to type prompts or intents.

Keyboard extensions have little native support for this. The text document proxy will not return all the text within the document, and may cancel at any time. You also can't type in text fields within the keyboard, since text is always sent to the main app.

[KeyboardKit Pro][Pro] unlocks these capabilities, and makes it possible to read the full document and type in a text field within the keyboard.



## 👑 Pro features

### Full Document Reader

[KeyboardKit Pro][Pro] unlocks ways to read **all** text from a text field, using the **fullDocumentContext** text document proxy extensions that are unlocked by the Silver and Gold tiers.

By reading the full text in the main app, you can pass in more information to your AI model or ChatGPT powered functionality, and make your AI-based features a lot more capable.

Read more in the <doc:Proxy-Article> article.


### Text Routing

[KeyboardKit Pro][Pro] unlocks ways to route text from the main app to text fields within the keyboard extension. It has a **KeyboardTextField** view that handles this automatically.

This makes it easy to build AI-based features that require user input within the keyboard, such as generating custom images with Open AI and DALL·E, asking questions to an AI, etc.

Read more in the <doc:Text-Routing-Article> article.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

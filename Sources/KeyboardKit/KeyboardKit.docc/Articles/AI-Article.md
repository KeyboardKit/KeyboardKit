# AI Support

This article describes the KeyboardKit AI support capabilities.

[KeyboardKit Pro][Pro] provides additional functionality that may be needed by AI-based keyboards.

For instance, AI-based keyboards may need to read the entire document to perform tasks like spellchecking and proofreading, and to let users type what they want to achieve.

However, keyboard extensions have little native support for this. The text document proxy will not return all the text in the document, and you can't type in text fields within the keyboard.

[KeyboardKit Pro][Pro] therefore unlocks these capabilities, and makes it possible to read the full document and to type in text fields within the keyboard extension.



## 👑 Pro features

### Full Document Reader

Keyboard extensions are by default only able to get a little text before and after the input cursor. This makes it hard to implement AI-based text analysis, spellchecking, and proof reading.

[KeyboardKit Pro][Pro] unlocks ways to read **all** text from a text field, using the **fullDocumentContext** text document proxy extensions that are unlocked by the Silver and Gold tiers.

By reading the full text, you can pass in more information to your AI model or ChatGPT powered functionality, and make your AI-based features a lot more capable.

Read more in the <doc:Proxy-Utilities-Article> article.


### Text Routing

Keyboard extensions will by default type into the active app. Adding text fields to the keyboard extension doesn't work, since the keyboard will still send text to the main app.

This makes it hard to add AI-based features that require user input within the keyboard, such as generating custom images with Open AI and DALL·E, asking questions to an AI, etc.

[KeyboardKit Pro][Pro] unlocks ways to route text from the main app to text fields within the keyboard extension. It also has a **KeyboardTextField** that handles this automatically.

Read more in the <doc:Text-Routing-Article> article.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

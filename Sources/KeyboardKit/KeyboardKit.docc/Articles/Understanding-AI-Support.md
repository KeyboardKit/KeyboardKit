# Understanding AI Support

This article describes the KeyboardKit AI support.

AI-based keyboard features may need access to the entire document, to be able to perform tasks like spellchecking and proofreading, and may also need users to type what they want to achieve.

However, keyboard extensions have very little native support for this. The text document proxy will not return all the text in the document, and you can't type in text fields within the keyboard.

[KeyboardKit Pro][Pro] therefore unlocks capabilities that are needed for AI-based features, such as making it possible to read the full document content and to type in text fields within the keyboard.



## 👑 Pro features

### Full Document Reader

Keyboard extensions will by default only get a little bit of text before and after the input cursor. This makes it hard to build support for AI-based text analysis, spellchecking, and proof reading.

KeyboardKit Pro unlocks ways to let a keyboard and its text document proxy read the entire text in the currently selected text field (a.k.a. the text document proxy).

By getting access to all the text in the text document proxy, you can pass in a lot more information to your AI model or ChatGPT powered functionality and make AI-based features a lot more capable.

Read more in <doc:Understanding-Proxy-Utilities>.


### Text Routing

Keyboard extensions will by default type into the currently selected text field in the currrently active app. Adding a text field to the keyboard doesn't work, since the keyboard will not type into it.

This makes it hard to build AI-based features into your keyboard, that requires user input, such as generating custom images with Open AI and DALL·E, asking questions to an AI, etc.

KeyboardKit Pro unlocks ways to route text from the main app to a text field within the keyboard. It also has specific text input views that handle this automatically for you.

Read more in <doc:Understanding-Text-Routing>.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

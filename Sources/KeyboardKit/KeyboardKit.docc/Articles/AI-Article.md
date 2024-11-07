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

👑 [KeyboardKit Pro][Pro] unlocks these capabilities to make it possible to read the full document and type in a text field within the keyboard.


---

## 👑 KeyboardKit Pro

### Full Document Reader

Apple's native text document proxy doesn't return all the text within the document. It instead cuts off the available text at any time, e.g. at the previous or next paragraph. This makes it hard to provide AI-based features that require more context.

KeyboardKit Pro unlocks ways to read **all** text from a text field, using the ``UIKit/UITextDocumentProxy/fullDocumentContext(config:)`` proxy extensions that reads the full document content by moving the input cursor in intricate ways to unlock more content.

See the <doc:Proxy-Article> article for more information.


### Text Input Support

Apple's native input controller & text document proxy don't let you type in text fields within the keyboard. Instead, text will be sent to the main app even if a text field in the keyboard is focused. This makes it hard to let user perform AI-based prompting within the keyboard.

KeyboardKit Pro unlocks ways to let users type within a keyboard extension, by routing text input from the main app to text fields within the keyboard, without the need for any additional code.

See the <doc:Text-Input-Article> article for more information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

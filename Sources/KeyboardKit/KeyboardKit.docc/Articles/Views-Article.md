# Views

This article describes various KeyboardKit views.

KeyboardKit has views in many different parts of the library. Some are top-level components, while others are nested in namespaces.

This article shows some of the views that are provided by the library. Please see the indivudual articles for even more views, and for more info on how to customize and style these views. 

[KeyboardKit Pro][Pro] unlocks more views, that take your keyboards to the next level. Information about Pro features is found in each article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Essential Views

See the <doc:Essentials> article for more information.

@Row {
    @Column {
        ``SystemKeyboard``
    }
    @Column {
        ![SystemKeyboard](systemkeyboard-english.jpg)
    }
}

@Row {
    @Column {
        ``Keyboard`` ``KeyboardButton/Button``
    }
    @Column {
        ![Keyboard Button](systemkeyboardbuttonpreview.jpg)
    }
}

@Row {
    @Column {
        ``Keyboard`` ``Keyboard/Toolbar``
    }
    @Column {
        ![Keyboard Toolbar](autocompletetoolbar.jpg)
    }
}

@Row {
    @Column {
        ``NextKeyboardButton``
    }
    @Column {
        ![Next Keyboard Button](nextkeyboardbutton.jpg)
    }
}

See the <doc:Essentials> article for more information.


## Autocomplete

See the <doc:Autocomplete-Article> article for more information.

@Row {
    @Column {
        ``Autocomplete`` ``Autocomplete/Toolbar``
    }
    @Column {
        ![Autocomplete Toolbar](autocompletetoolbar.jpg)
    }
}


## Callouts

See the <doc:Callouts-Article> article for more information.

@Row {
    @Column {
        ``Callouts`` ``Callouts/InputCallout``
    }
    @Column {
        ![Input Callout](inputcallout)
    }
}
@Row {
    @Column {
        ``Callouts`` ``Callouts/ActionCallout``
    }
    @Column {
        ![Action Callout](actioncallout)
    }
}


## Dictation

See the <doc:Dictation-Article> article for more information.

@Row {
    @Column {
        ``Dictation`` ``Dictation/Screen``
        
        ``Dictation`` ``Dictation/BarVisualizer``
    }
    @Column {
        ![Dictation Screen & Bar Visualizer](dictationscreen)
    }
}


## Emoji Views

See the <doc:Emojis-Article> article for more information.

@Row {
    @Column {
        ``EmojiKeyboard``
    }
    @Column {
        ![Emoji Keyboard](emojikeyboard.jpg)
    }
}


## Images

See the <doc:Images-Article> article for more information.

@Row {
    @Column {
        ``SwiftUI/Image``
    }
    @Column {
        ![Images](images.jpg)
        
        ![Images](images-emojis.jpg)
    }
}


## Localization

See the <doc:Localization-Article> article for more information.

@Row {
    @Column {
        ``LocaleContextMenu``
    }
    @Column {
        ![LocaleContextMenu](localecontextmenu.jpg)
    }
}


## Previews

See the <doc:Previews-Article> article for more information.

@Row {
    @Column {
        ``SystemKeyboardPreview``
    }
    @Column {
        ![System Keyboard Preview - Theme](systemkeyboardpreview-theme.jpg)
    }
}

@Row {
    @Column {
        ``SystemKeyboardButtonPreview``
    }
    @Column {
        ![System Keyboard Button Preview](systemkeyboardbuttonpreview.jpg)
    }
}


## State

See the <doc:State-Article> article for more information.

@Row {
    @Column {
        ``KeyboardStateLabel``
    }
    @Column {
        ![Keyboard State Label](keyboardstatelabel.jpg)
    }
}


## Text Routing

KeyboardKit Pro unlocks a ``KeyboardTextField`` and a ``KeyboardTextView``, that let you type into a text field within the keyboard extension, by automatically registering and unregistering themselves as the main input proxy when they get and lose focus.

See the <doc:Text-Routing-Article> article for more information.




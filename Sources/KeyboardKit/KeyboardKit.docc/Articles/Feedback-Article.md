# Feedback

This article describes the KeyboardKit feedback engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

Feedback is an important part of the typing experience, where a keyboard can trigger audio and haptic feedback when a user taps on a key or performs certain actions.

In KeyboardKit, audio and haptic feedback can be triggered with a ``KeyboardActionHandler`` or by using the ``Feedback/Audio`` and ``HapticFeedback`` ``Feedback/Audio/trigger()`` functions directly.

👑 [KeyboardKit Pro][Pro] unlocks a convenient feedback toggle view. Information about Pro features can be found at the end of this article.



## Feedback Namespace

KeyboardKit has a ``Feedback`` namespace with feedback-related types, like ``Feedback/Audio``, ``Feedback/Haptic``, etc.



## Audio feedback

KeyboardKit has an ``Feedback/Audio`` feedback enum that defines various standard audio feedback types, like ``Feedback/Audio/input``, ``Feedback/Audio/system``, ``Feedback/Audio/delete``, etc.

This enum also serves as a namespace for other audio feedback-related types like ``Feedback/AudioConfiguration`` and ``Feedback/AudioEngine``.



## Haptic feedback

KeyboardKit has an ``Feedback/Haptic`` feedback enum that defines various standard haptic feedback types, like ``Feedback/Haptic/success``, ``Feedback/Haptic/warning``, etc.

This enum also serves as a namespace for other haptic feedback-related types like ``Feedback/HapticConfiguration`` and ``Feedback/HapticEngine``.



## How to trigger feedback

You can trigger any ``Feedback/Audio`` and ``Feedback/Haptic`` feedback with the ``Feedback/Audio/trigger()`` enum functions:

```swift
Feedback.Audio.input.trigger()
Feedback.Haptic.success.trigger()
```

You can also trigger feedback with a ``KeyboardActionHandler``, using ``KeyboardActionHandler/triggerFeedback(for:on:)``. You can either use the feedback configuration described below to customize the feedback, or create a custom action handler. 



## How to configure feedback

KeyboardKit has an observable ``FeedbackConfiguration`` that can be used to configure feedback for various actions. 

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``. You can use this instance to configure feedback:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = state.feedbackConfiguration 
        config.audio = .disabled
        config.audio.input = .custom(id: 1329)
        config.haptic = .minimal
    }
}
```

Since the configuration is observable, any changes will automatically cause the keyboard to update, e.g. if you have feedback toggles.



## How to define custom audio feedback

Since ``Feedback/Audio`` uses **AudioServices** to play audio, you can use any system audio ID (see [this website](https://iphonedev.wiki/index.php/AudioServices) for info) as feedback. 

For instance, this is a way to define a custom sound:

```swift
extension Feedback.Audio {

    static let sentMessage = .custom(id: 1004)
}
```

You can also implement a custom action handler to trigger feedback in a different ways. See the <doc:Actions-Article> article for more information.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a convenient feedback toggle that can be added to a keyboard toolbar to toggle audio or haptic feedback.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

### Views

KeyboardKit Pro unlocks views in the ``FeedbackConfiguration`` namespace, that let you easily toggle audio and haptic feedback:

@TabNavigator {
    
    @Tab("Toggle") {
        
        The feedback ``Feedback/Toggle`` can be used to toggle audio & haptic feedback on and off. It can be added to a toolbar, or anywhere you want it.
        
        ![FeedbackToggle](feedbackconfigurationtoggle.jpg)
        
        The view can be customized with other icons, and be further styled with native accent colors, fonts, etc. It's currently not style-based.
    }
}



# Audio Feedback

KeyboardKit defines system audio types and ways to play them.


## System Audio

KeyboardKit has a `SystemAudio` enum with some pre-defined feedback types, such as:

*  `input` - represents the sound of an input key.
*  `system` - represents the sound of a system key.
*  `delete` - represents the sound of a delete key.

*  `custom` - represents a custom id-based sound.

*  `none` - represents no sound.

You can play these sounds directly, using the `play()` function.


## Configuration

KeyboardKit has an `AudioFeedbackConfiguration` type that lets you configure audio feedback.

KeyboardKit defines a few predefined configurations:

* `enabled` - enables all audio feedback 
* `noFeedback` - disables all audio feedback
* `standard` - is the standard configuration (`enabled`)

You can configure the audio feedback in your keyboard by modifying the `keyboardFeedbackSettings` of the input view controller or registering a custom `keyboardFeedbackHandler`.


## Full Access

Audio feedback requires full access. 


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on audio and haptic feedback.



[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true

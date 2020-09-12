# Audio Feedback

KeyboardKit has an `AudioFeedback` enum with these types:

*  `input`
*  `system`
*  `delete`
*  `custom`
*  `none`

You can enable audio feedback by providing `StandardKeyboardActionHandler` with an `audioConfiguration`. The default configuration is `standard`.

You can also trigger the various feedback types manually.

`IMPORTANT` Users must enable open access for audio feedback to work.

# Audio Feedback

KeyboardKit supports audio feedback, which means that users can get audio feedback as they type.

KeyboardKit comes with some built-in feedback types:

*  `input`
*  `system`
*  `delete`
*  `custom`
*  `none`

You can enable audio feedback by providing `keyboardActionHandler` with a audio feedback configuration.  The default configuration is `standard`.

`Important` Users must enable open access for audio feedback to work.

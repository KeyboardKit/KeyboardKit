# ``KeyboardKit/KeyboardInputViewController``

With KeyboardKit, inherit this class instead of the regular
`UIInputViewController` to extend the controller with a lot
of additional features, properties, services etc.


## View Controller Lifecycle

Regarding the view controller lifecycle, there are some new
functions that you can override. These should be overridden
to assure that the keyboard is kept in sync:

* ``viewWillSetupKeyboard()`` is called when the controller
needs to setup or recreate the keyboard view. Override this
and call `setup(with:)` to setup your main keyboard view.
* ``performAutocomplete()`` is called when a text change is
used to trigger an autocomplete operation. By default, this
makes the controller call the ``autocompleteProvider`` with
the ``textDocumentProxy``s `currentWord`, if any.
* ``resetAutocomplete()`` is called when the text selection
changes, e.g. when moving the cursor. By default, it resets
the ``autocompleteContext``.

The controller will by default use a ``SystemKeyboard``, so
you don't have to override ``viewWillSetupKeyboard()`` when
you just want to use the standard keyboard.


## Observable properties

This class provides you with many observable properties for
observing the keyboard's global state:

* ``autocompleteContext`` provides autocomplete information
* ``calloutContext`` provides callout state and information
* ``keyboardContext`` provides keyboard-specific information
* ``keyboardFeedbackSettings`` provides feedback settings
* ``keyboardTextContext`` provides keyboard text information

These contexts are injected as environment objects into the
root view and can be accessed anywhere in the hierarchy.


## Services

This class also provides you with services that you can use
to build more powerful keyboards:

* ``autocompleteProvider`` is used to get autocomplete suggestions
* ``calloutActionProvider`` is used to get callout actions
* ``inputSetProvider`` is used to get input characters for the keyboard layout
* ``keyboardActionHandler`` is used to handle keyboard actions
* ``keyboardAppearance`` is used to determine the keyboard design
* ``keyboardBehavior`` is used to determine the keyboard behavior
* ``keyboardFeedbackHandler`` is used to handle autio & haptic feedback
* ``keyboardLayoutProvider`` is used to get a keyboard layout

You can replace any of these to customize how your keyboard
extension behaves.

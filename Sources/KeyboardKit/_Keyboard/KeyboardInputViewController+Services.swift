//
//  KeyboardInputViewController+Services.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {
    
    /// The ``keyboardServices`` autocomplete provider.
    var autocompleteProvider: AutocompleteProvider { keyboardServices.autocompleteProvider }
    
    /// The ``keyboardServices`` callout action provider.
    var calloutActionProvider: CalloutActionProvider { keyboardServices.calloutActionProvider }
    
    /// The ``keyboardServices`` dictation service.
    var dictationService: KeyboardDictationService { keyboardServices.dictationService }
    
    /// The ``keyboardServices`` keyboard behavior.
    var keyboardBehavior: KeyboardBehavior { keyboardServices.keyboardBehavior }
    
    /// The ``keyboardServices`` layout provider.
    var layoutProvider: KeyboardLayoutProvider { keyboardServices.layoutProvider }
    
    /// The ``keyboardServices`` space drag gesture handler.
    var spaceDragGestureHandler: DragGestureHandler { keyboardServices.spaceDragGestureHandler }
    
    /// The ``keyboardServices`` style provider.
    var styleProvider: KeyboardStyleProvider { keyboardServices.styleProvider }
}

public extension KeyboardInputViewController {

    @available(*, deprecated, renamed: "layoutProvider")
    var keyboardLayoutProvider: KeyboardLayoutProvider { layoutProvider }
    
    @available(*, deprecated, renamed: "styleProvider")
    var keyboardStyleProvider: KeyboardStyleProvider { styleProvider }
}
#endif

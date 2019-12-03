//
//  KeyboardViewController+Autocomplete.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func requestAutocompleteSuggestions() {
        let word = textDocumentProxy.currentWord ?? ""
        autocompleteProvider.autocompleteSuggestions(for: word) { [weak self] in
            switch $0 {
            case .failure(let error): print(error.localizedDescription)
            case .success(let result): self?.autocompleteToolbar.update(with: result)
            }
        }
    }
    
    func resetAutocompleteSuggestions() {
        autocompleteToolbar.reset()
    }
}

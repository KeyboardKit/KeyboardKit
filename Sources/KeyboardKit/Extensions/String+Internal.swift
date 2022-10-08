//
//  String+Internal.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-08.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

extension String {

    var hasTrimmedContent: Bool {
        !trimmed().isEmpty
    }

    func split(by separators: [String]) -> [String] {
        let separators = CharacterSet(charactersIn: separators.joined())
        return components(separatedBy: separators)
    }

    func trimmed() -> String {
        trimmingCharacters(in: .whitespaces)
    }
}

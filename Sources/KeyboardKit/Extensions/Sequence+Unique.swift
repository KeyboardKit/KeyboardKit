//
//  Sequence+Unique.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {

    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

//
//  UITextDocumentProxy+Delete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITextDocumentProxy {

    func deleteBackward(times: Int) {
        for _ in 0..<times {
            deleteBackward()
        }
    }
}

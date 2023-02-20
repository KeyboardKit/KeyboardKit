//
//  FullDocumentContextReaderState.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-01.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This static class is used as `UITextDocumentProxy` state in
 KeyboardKit Pro, when reading the full document context.

 This class is defined in the core library to make the input
 controller able to check if a proxy is currently performing
 a read operation, although the functionality is implemented
 in KeyboardKit Pro.
 */
final class FullDocumentContextReaderState {

    private init() {}

    static var isReadingFullDocumentContext = false
}

//
//  ViewController.swift
//  KeyboardKitExample
//
//  Created by Daniel Saidi on 2018-03-02.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

class ViewController: UIViewController {

    
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView? {
        didSet { textView?.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0) }
    }
}

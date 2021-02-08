//
//  ViewController.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2019-10-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView? {
        didSet { textView?.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0) }
    }
}

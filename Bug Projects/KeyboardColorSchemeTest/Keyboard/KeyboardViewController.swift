//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-07-17.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBOutlet var appearanceLabel: UILabel!
    @IBOutlet var schemeLabel: UILabel!
    @IBOutlet var systemSchemeLabel: UILabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.updateLabels()
        }
        
        appearanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        schemeLabel = UILabel(frame: CGRect(x: 0, y: 30, width: 300, height: 30))
        systemSchemeLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 300, height: 30))
        view.addSubview(appearanceLabel)
        view.addSubview(schemeLabel)
        view.addSubview(systemSchemeLabel)
        
        let image1 = UIImageView(image: UIImage(named: "key_lightmode"))
        let image2 = UIImageView(image: UIImage(named: "key_darkmode"))
        image1.frame.origin = CGPoint(x: 0, y: 100)
        image2.frame.origin = CGPoint(x: 150, y: 100)
        view.addSubview(image1)
        view.addSubview(image2)
        
        // Perform custom UI setup here
        nextKeyboardButton = UIButton(type: .system)
        nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        view.addSubview(nextKeyboardButton)
        
        nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        //self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        var textColor: UIColor
        let proxy = textDocumentProxy
        let isDark = proxy.keyboardAppearance == .dark
        textColor = isDark ? .white : .black
        nextKeyboardButton.setTitleColor(textColor, for: [])
        updateLabels()
    }
    
    func updateLabels() {
        
        // Various values to try finding one that defines the system color scheme, not the extension's
        let parentColorScheme = parent?.traitCollection.userInterfaceStyle          // Always dark for dark appearance
        let screenColorScheme = UIScreen.main.traitCollection.userInterfaceStyle    // Always dark
        let systemColorScheme: UIUserInterfaceStyle? = screenColorScheme
        
        let proxy = textDocumentProxy
        appearanceLabel.text = "Keyboard apperance: \(proxy.keyboardAppearance?.displayValue ?? "-") "
        schemeLabel.text = "Color scheme: \(view.traitCollection.userInterfaceStyle.displayValue)"
        systemSchemeLabel.text = "System color scheme: \(systemColorScheme?.displayValue ?? "-")"
        //view.backgroundColor = view.backgroundColor == .red ? .gray : .red        // To verify that the timer ticks
    }
}

extension UIKeyboardAppearance {
    
    var displayValue: String {
        switch self {
        case .dark: return "dark"
        case .default: return "default"
        case .light: return "light"
        case .alert: return "alert"
        @unknown default: return "!!!"
        }
    }
}

extension UIUserInterfaceStyle {
    
    var displayValue: String {
        switch self {
        case .dark: return "dark"
        case .light: return "light"
        case .unspecified: return "unspecified"
        @unknown default: return "!!!"
        }
    }
}

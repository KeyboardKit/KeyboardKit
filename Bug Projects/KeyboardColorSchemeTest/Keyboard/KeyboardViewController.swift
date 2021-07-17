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
        
        addLabels()
        addImages()
        
        // Perform custom UI setup here
        nextKeyboardButton = UIButton(type: .system)
        nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        view.addSubview(nextKeyboardButton)
        
        overrideUserInterfaceStyle = .unspecified
        
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
    
    func addLabels() {
        appearanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        schemeLabel = UILabel(frame: CGRect(x: 0, y: 30, width: 300, height: 30))
        systemSchemeLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 300, height: 30))
        view.addSubview(appearanceLabel)
        view.addSubview(schemeLabel)
        view.addSubview(systemSchemeLabel)
    }
    
    func addImages() {
        let key_lightappearance_lightmode = UIImageView(image: UIImage(named: "key_lightappearance_lightmode"))
        let key_lightappearance_darkmode = UIImageView(image: UIImage(named: "key_lightappearance_darkmode"))
        let key_darkappearance_lightmode = UIImageView(image: UIImage(named: "key_darkappearance_lightmode"))
        let key_darkappearance_darkmode = UIImageView(image: UIImage(named: "key_darkappearance_darkmode"))
        key_lightappearance_lightmode.frame.origin = CGPoint(x: 300, y: 0)
        key_lightappearance_darkmode.frame.origin = CGPoint(x: 350, y: 0)
        key_darkappearance_lightmode.frame.origin = CGPoint(x: 300, y: 100)
        key_darkappearance_darkmode.frame.origin = CGPoint(x: 350, y: 100)
        view.addSubview(key_lightappearance_lightmode)
        view.addSubview(key_lightappearance_darkmode)
        view.addSubview(key_darkappearance_lightmode)
        view.addSubview(key_darkappearance_darkmode)
    }
    
    func updateLabels() {
        
        // Various values to try finding one that defines the system color scheme, not the extension's
        let parentScheme = parent?.traitCollection.userInterfaceStyle          // Always dark for dark appearance
        let screenScheme = UIScreen.main.traitCollection.userInterfaceStyle    // Always dark
        let systemColorScheme: UIUserInterfaceStyle? = screenScheme
        
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

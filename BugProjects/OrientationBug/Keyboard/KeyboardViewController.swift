//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-09-24.
//

import UIKit
import KeyboardKit
import SwiftUI

class SizeContext: ObservableObject {
    
    @Published var size: CGSize = .zero
    
    var isLandscape: Bool { size.width > size.height }
}

class KeyboardViewController: KeyboardInputViewController {
    
    private let size = SizeContext()
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        size.size = UIScreen.main.bounds.size
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This is the hosting controller from KeyboardKit
        // KeyboardHostingController(rootView: grid)
        // This is the hosting controller from further down.
        TestHostingController(rootView: KeyboardView(size: size))
            .add(to: self)
        
        setupNextKeyboardButton()
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
        
        /**
         Uncomment to fix bug
         */
        /**
        size.size = UIScreen.main.bounds.size
        DispatchQueue.main.async {
            TestHostingController(rootView: KeyboardView(size: self.size))
                .add(to: self)
        }
         */
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        view.backgroundColor = .random
    }
}

extension GeometryProxy {
    
    var isLandscape: Bool {
        size.width > size.height
    }
}

struct KeyboardView: View {
    
    init(size: SizeContext) {
        _size = ObservedObject(wrappedValue: size)
    }
    
    @ObservedObject private var size: SizeContext
    
    var body: some View {
        stack
    }
}

extension KeyboardView {
    
    var grid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50, maximum: 100))]) {
            ForEach(0...30, id: \.self) { _ in
                Color.random.frame(maxHeight: .infinity)
            }
        }.frame(height: 300)
    }
    
    var stack: some View {
        VStack {
            ForEach(0...3, id: \.self) { _ in
                HStack {
                    ForEach(0...3, id: \.self) { _ in
                        Color.random
                            .frame(height: size.isLandscape ? 50 : 100)
                            .overlay(Text("\(Int(size.size.width)),\(Int(size.size.height))"))
                    }
                }
            }
        }//.frame(height: 300)
    }
}


extension KeyboardViewController {
    
    func setupNextKeyboardButton() {
        nextKeyboardButton = UIButton(type: .system)
        nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard \(size.size)", comment: "Title for 'Next Keyboard' button"), for: [])
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        view.addSubview(nextKeyboardButton)
        nextKeyboardButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nextKeyboardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

public class TestHostingController<Content: View>: UIHostingController<Content> {
    
    public func add(to controller: KeyboardInputViewController) {
        controller.addChild(self)
        controller.view.addSubview(view)
        didMove(toParent: controller)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
    }
}




extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

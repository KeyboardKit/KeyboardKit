//
//  KeyboardView.swift
//  LeakTest
//
//  Created by Daniel Saidi on 2023-02-19.
//

import SwiftUI
import KeyboardKit

struct KeyboardView: View {

    let controller = KeyboardController()

    var body: some View {
        VStack {
            SystemKeyboard(controller: controller)
            Text("Locale: \(controller.keyboardContext.locale.identifier)")
        }
        .padding()
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}

class KeyboardController: KeyboardInputViewController {

    required init?(coder: NSCoder) {
        Self.instances += 1
        super.init(coder: coder)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        Self.instances += 1
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    static var instances = 0

    deinit {
        Self.instances -= 1
        print("DEINIT")
    }
}

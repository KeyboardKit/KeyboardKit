//
//  DemoKeyboardView.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This view uses a `SystemKeyboard` as the keyboard view, and
 customizes it with some Pro features.
 
 Note that `setup` and `setupPro` will use a `SystemKeyboard`
 by default, if you don't provide a custom view.
 
 Just return `$0.view` in the `SystemKeyboard` view builders,
 if you just want to use the default view.
 
 > Important: When you customize your view, you need to make
 it observe the `KeyboardContext` in the environment. If you
 don't, this view will not detect any changes in the context
 and will not update itself.
 */
struct DemoKeyboardView: View {
    
    var state: Keyboard.KeyboardState
    var services: Keyboard.KeyboardServices
    
     @State
     private var fullDocumentContext: String?
    
    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    
    var body: some View {
        SystemKeyboard(
            state: state,
            services: services,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: {
                 try? ToggleToolbar.init(
                     toolbar: $0.view,
                     toggledToolbar: toggledToolbar
                 )
            }
        )
        .sheet(item: $fullDocumentContext, content: fullDocumentContextSheet)
    }
}

private extension DemoKeyboardView {
    
    var toggledToolbar: some View {
        HStack {
            Spacer()
            Button(action: readFullDocumentContext) {
                Image(systemName: "doc.text.magnifyingglass")
            }
        }
        .font(.headline)
        .padding(.horizontal, 10)
        .buttonStyle(.bordered)
    }
    
    func fullDocumentContextSheet(text: String?) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Document text")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(text ?? "-")
            }.padding()
        }
    }
}

private extension DemoKeyboardView {
    
    var proxy: UITextDocumentProxy {
        state.keyboardContext.textDocumentProxy
    }
    
    func readFullDocumentContext() {
        fullDocumentContext = "Reading..."
        Task {
            let result = try await proxy.fullDocumentContext()
            await MainActor.run { self.fullDocumentContext = result.fullDocumentContext }
        }
    }
}


// MARK: - Convenience extensions

extension String: Identifiable {
    
    public var id: String { self }
}

//
//  FullDocumentContextSheet.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2024-11-25.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This sheet is used to trigger full document context read
/// operations in the demo app.
struct FullDocumentContextSheet: View {

    @EnvironmentObject var keyboardContext: KeyboardContext

    @State var isReading = false
    @State var fullDocumentContext = ""

    var body: some View {
        List {
            Section("Sheet.FullDocumentContext.ResultPrefix") {
                if isReading {
                    Text("Sheet.FullDocumentContext.Reading")
                } else {
                    Text(fullDocumentContext)
                }
            }
        }
        .onAppear(perform: readFullDocumentContext)
        .navigationTitle("Sheet.FullDocumentContext")
    }
}

private extension FullDocumentContextSheet {

    func readFullDocumentContext() {
        isReading = true
        fullDocumentContext = ""
        Task {
            let result = try await keyboardContext.textDocumentProxy.fullDocumentContext()
            await MainActor.run {
                self.isReading = false
                self.fullDocumentContext = result.fullDocumentContext
            }
        }
    }
}

#Preview {
    FullDocumentContextSheet()
}

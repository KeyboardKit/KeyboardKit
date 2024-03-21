//
//  ContentView.swift
//  LeakTest
//
//  Created by Daniel Saidi on 2023-02-19.
//

import SwiftUI

struct ContentView: View {

    @State
    private var isSheetActive = false

    var body: some View {
        VStack {
            Button("To keyboard") {
                isSheetActive.toggle()
            }
            Button("Print instances") {
                print(KeyboardController.instances)
            }
        }
        .padding()
        .sheet(isPresented: $isSheetActive) {
            KeyboardView()
        }
    }
}

#Preview {
    ContentView()
}

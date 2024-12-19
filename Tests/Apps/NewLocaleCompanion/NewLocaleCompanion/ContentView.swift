//
//  ContentView.swift
//  NewLocaleCompanion
//
//  Created by Daniel Saidi on 2024-12-19.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = ""
    @State var returnTypeIndex = 0
    
    let returnTypes: [SubmitLabel] = [
        .continue,  // малалла тy
        .done,      // вӗҫле
        .go,        // каҫни
        .join,      // ҫыхӑнтарас
        .next,      // тепӗр
        .return,    // кӗртни
        .route,     // маршрут
        .search,    // шырав
        .send       // яр
    ]
    
    var body: some View {
        VStack {
            Text("\(returnTypeIndex)")
            Button("Next", action: nextType)
            TextField("", text: $text)
                .id(returnTypeIndex)
                .submitLabel(returnTypes[returnTypeIndex])
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
    
    func nextType() {
        if returnTypeIndex == returnTypes.count - 1 {
            return returnTypeIndex = 0
        }
        returnTypeIndex += 1
    }
}

#Preview {
    ContentView()
}

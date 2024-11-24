//
//  HostAppInfoSheet.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2024-11-25.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This sheet shows host application information within the
/// keyboard extension.
struct HostAppInfoSheet: View {

    @Environment(\.openURL) var openURL

    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        List {
            Section("Sheet.Host.Section.BundleID") {
                Text(keyboardContext.hostApplicationBundleId ?? "")
            }
            Section("Sheet.Host.Section.App") {
                if let app = try? keyboardContext.hostApplication {
                    item(
                        title: "Sheet.Host.Section.App.Name",
                        subtitle: app.name
                    )
                    item(
                        title: "Sheet.Host.Section.App.BundleId",
                        subtitle: app.bundleId
                    )
                    item(
                        title: "Sheet.Host.Section.App.CanOpen",
                        subtitle: (app.url != nil) ? "✔" : "✘"
                    )
                } else {
                    Text("Sheet.Host.Section.App.Unknown")
                }
            }
            Section("Sheet.Host.Section.KnownApps") {
                ForEach(KeyboardHostApplication.allCases) { app in
                    Button {
                        guard let url = app.url else { return }
                        openURL.callAsFunction(url)
                    } label: {
                        Text(app.name)
                    }
                }
            }
        }
        .navigationTitle("Sheet.Host")
    }
}

private extension HostAppInfoSheet {

    func item(
        title: LocalizedStringKey,
        subtitle: String
    ) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(subtitle)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HostAppInfoSheet()
}

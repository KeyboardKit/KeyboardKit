//
//  HostAppInfoSheet.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2024-11-25.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This sheet shows host application information within the
/// keyboard extension.
struct HostAppInfoSheet: View {
    
    let actionHandler: KeyboardActionHandler

    @Environment(\.openURL) var openURL

    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        List {
            Section("Sheet.Host.Section.BundleID") {
                Text(keyboardContext.hostApplicationBundleId ?? "")
            }
            Section("Sheet.Host.Section.App") {
                if let app = try? keyboardContext.hostApplication {
                    infoItems(for: app)
                } else {
                    Text("Sheet.Host.Section.App.Unknown")
                }
            }
            Section("Sheet.Host.Section.KnownApps") {
                ForEach(KeyboardHostApplication.allCases) { app in
                    listItem(for: app)
                }
            }
        }
        .navigationTitle("Sheet.Host")
    }
}

private extension HostAppInfoSheet {

    @ViewBuilder
    func infoItems(
        for app: KeyboardHostApplication
    ) -> some View {
        infoItem(
            title: "Sheet.Host.Section.App.Name",
            subtitle: app.name
        )
        infoItem(
            title: "Sheet.Host.Section.App.BundleId",
            subtitle: app.bundleId
        )
        infoItem(
            title: "Sheet.Host.Section.App.CanOpen",
            subtitle: app.canBeOpened ? "✔" : "✘"
        )
    }

    func infoItem(
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
    
    @ViewBuilder
    func listItem(
        for app: KeyboardHostApplication
    ) -> some View {
        if app.canBeOpened {
            Button(app.name) {
                app.open(with: actionHandler)
            }
        } else {
            Text(app.name)
        }
    }
}

#Preview {
    HostAppInfoSheet(
        actionHandler: .preview
    )
}

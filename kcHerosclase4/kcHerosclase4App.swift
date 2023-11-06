//
//  kcHerosclase4App.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

@main
struct kcHerosclase4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

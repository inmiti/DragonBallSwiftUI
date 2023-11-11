//
//  kcHerosclase4App.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

@main
struct kcHerosclase4App: App {
    let persistenceController = PersistenceController.shared //Core data
    
    //ViewModel global
    @StateObject var rootViewModel = RootViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(rootViewModel)
        }
    }
}

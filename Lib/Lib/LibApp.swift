//
//  LibApp.swift
//  Lib
//
//  Created by ifpb on 03/07/23.
//

import SwiftUI

@main
struct LibApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

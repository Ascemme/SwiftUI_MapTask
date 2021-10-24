//
//  MapTaskSwiftUIApp.swift
//  MapTaskSwiftUI
//
//  Created by Temur on 21/10/2021.
//

import SwiftUI

@main
struct MapTaskSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

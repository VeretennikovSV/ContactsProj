//
//  ContactListApp.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import CoreData
import SwiftUI

@main
struct ContactListApp: App {
    
    @Environment(\.managedObjectContext) var context
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            DemoView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

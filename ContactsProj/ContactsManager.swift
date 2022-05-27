//
//  DataManager.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import Foundation

class Contacts: ObservableObject {
    
    @Published var contacts: [TestContact] = [TestContact(name: "Anton", secondName: "123", phone: "123221"), TestContact(name: "Anton", secondName: "879826734", phone: "123332221")]
    @Published var randomContacts = Generation.shared.callContacts()
    
    
    static func getOneContact() -> TestContact {
        TestContact(name: "Sergei", secondName: "228", phone: "1000900")
    }
    
}

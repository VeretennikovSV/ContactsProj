//
//  DataManager.swift
//  ContactList
//
//  Created by Сергей Веретенников on 23/05/2022.
//

import Foundation

struct Generation {
    
    static var shared = Generation()
    private init() {}
    
    let names = ["Sergey", "Anton", "Slava", "Nikolai", "Vasili", "Elena", "Love", "Dmitry", "George"]
    let secondNames = ["Kolesnikov", "Ivanov", "Veretennikov", "Vasiliev", "Alexandrov", "Naumov", "Alexeev", "Baburin", "Andreev"]
    
    func callContacts() -> [TestContact] {
        var count = 0
        var newContacts: [TestContact] = []
        
        while count <= 10 {
            guard let name = Generation.shared.names.randomElement() else { return [TestContact()] }
            guard let secondName = Generation.shared.secondNames.randomElement() else { return [TestContact()] }
            let contact = TestContact(name: name, secondName: secondName, phone: "2281488")
            newContacts.append(contact)
            count += 1
        }
        
        return newContacts
    }
}

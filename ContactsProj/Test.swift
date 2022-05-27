//
//  Test.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import Foundation

struct TestContact: Identifiable, Codable {
    
    let name: String
    let secondName: String
    let phone: String
    var id = UUID()
    
    init() {
        name = ""
        secondName = ""
        phone = ""
    }
    
    init(name: String, secondName: String, phone: String) {
        self.name = name
        self.secondName = secondName
        self.phone = phone
    }
}

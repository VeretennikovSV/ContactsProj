//
//  ModelsForFetch.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 28/05/2022.
//

import Foundation

struct ContactInfo: Codable {
    let results: [RandomContact]
}

struct RandomContact: Codable {
    
    
    let name: Name
    
    let email: String
    
    let phone: String
    
    let picture: Picture
    
}

struct Name: Codable  {
    
    let title: String
    let first: String
    let last: String
    
}

struct Dob: Codable  {
    let date: Date
    let age: Int
}

struct Picture: Codable {
    let large: String
}

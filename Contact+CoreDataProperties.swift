//
//  Contact+CoreDataProperties.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 26/05/2022.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var number: String
    @NSManaged public var picture: Data?
    @NSManaged public var secondName: String

}

extension Contact : Identifiable {

}

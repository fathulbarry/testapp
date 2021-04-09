//
//  User+CoreDataProperties.swift
//  TestApp
//
//  Created by Prijo on 4/6/21.
//  Copyright © 2021 Tawk. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar_url: String?
    @NSManaged public var id: Int16
    @NSManaged public var login: String
    @NSManaged public var notes: String?
    @NSManaged public var url: String
    @NSManaged public var followers: Int16
    @NSManaged public var following: Int16
    @NSManaged public var name: String?
    @NSManaged public var company: String?
    @NSManaged public var blog: String?
    @NSManaged public var location: String?
    @NSManaged public var email: String?

}

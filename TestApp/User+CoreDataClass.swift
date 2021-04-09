//
//  User+CoreDataClass.swift
//  TestApp
//
//  Created by Prijo on 4/6/21.
//  Copyright © 2021 Tawk. All rights reserved.
//
//

import Foundation
import CoreData

//@objc(User)
public class User: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case avatar_url = "avatar_url"
        case id = "id"
        case login = "login"
        case notes = "notes"
        case url = "url"
        case followers = "followers"
        case following = "following"
        case name = "name"
        case company = "company"
        case blog = "blog"
        case location = "location"
        case email = "email"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
        else {
            fatalError("Failed to decode")
        }

        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            avatar_url = try values.decode(String.self, forKey: .avatar_url)
            id = try values.decode(Int16.self, forKey: .id)
            login = try values.decode(String.self, forKey: .login)
            url = try values.decode(String.self, forKey: .url)
        } catch {
            print("Error decoding \(error.localizedDescription)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id, forKey: .id)
        } catch {
            print("error")
        }
    }
}

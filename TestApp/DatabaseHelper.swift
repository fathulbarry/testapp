//
//  DatabaseHelper.swift
//  TestApp
//
//  Created by Prijo on 4/5/21.
//  Copyright © 2021 Tawk. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHelper {
    let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add() -> User? {
        guard let entityName = User.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        return User(entity: entity, insertInto: viewContext)
    }

    func load(_ id: Int16? = nil) -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            if let id = id {
                let result = try viewContext.fetch(request).filter { $0.id == id }
                return result
            } else {
                let result = try viewContext.fetch(request)
                return result.sorted { $0.id < $1.id }
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func commit() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

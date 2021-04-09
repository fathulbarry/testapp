//
//  Extensions.swift
//  TestApp
//
//  Created by Prijo on 4/6/21.
//  Copyright © 2021 Tawk. All rights reserved.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

extension NSPersistentContainer {
    func commit(bgContext: NSManagedObjectContext? = nil) {
        let context = bgContext ?? viewContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
    }
}

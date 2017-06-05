//
//  Service+CoreDataProperties.swift
//  mfc38
//
//  Created by Алексей Усанов on 10.07.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Service {

    @NSManaged var name: String?
    @NSManaged var organizationText: String?

}

//
//  Record.swift
//  storehub
//
//  Created by Julius Iglesia on 31/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation
import CoreData

public class Record: NSManagedObject, Identifiable {
    @NSManaged public var id: String?
    @NSManaged public var createdBy: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var updatedBy: String?
    @NSManaged public var updateDate: Date?
    
    public var wrappedId: String {
        id ?? "Unknown ID"
    }
    
    public func setUpdateTimestamp() {
        self.setUpdateTimestamp(by: "system")
    }
    
    public func setUpdateTimestamp(by: String) {
        self.updatedBy = by
        self.updateDate = Date()
    }
    
    public func setCreateTimestamp() {
        self.setCreateTimestamp(by: "system")
    }
    
    public func setCreateTimestamp(by: String) {
        self.id = UUID().uuidString
        self.setUpdateTimestamp(by: by)
        self.createdBy = by
        self.createDate = Date()
    }
}

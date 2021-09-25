//
//  Task+CoreDataProperties.swift
//  TaskList
//
//  Created by Muhammad Abdullah Al Mamun on 25/9/21.
//
//

import Foundation
import CoreData


extension Task {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var taskname: String?
    @NSManaged public var tasktype: String?
    
    
    func toConvertTask() -> TaskModel{
        return TaskModel(id: self.id!, taskName: self.taskname, taskType: self.tasktype)
    }
    
}



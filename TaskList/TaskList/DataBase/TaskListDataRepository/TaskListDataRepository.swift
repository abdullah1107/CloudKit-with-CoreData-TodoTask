//
//  TaskListDataRepository.swift
//  TaskList
//
//  Created by Muhammad Abdullah Al Mamun on 25/9/21.
//

import Foundation
import CoreData
import CloudKit

protocol BaseRepository {

    associatedtype T

    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: UUID) -> Bool
}




protocol TaskListRepository : BaseRepository {

}




struct TasklistDataRepository: TaskListRepository {
    
    
    
    func create(record: TaskModel) {

        let cdTask = Task(context: PersistentStorage.shared.context)
        
        cdTask.id = record.id
        cdTask.taskname = record.taskName
        cdTask.tasktype = record.taskType
    
        PersistentStorage.shared.saveContext()
    }
    
    
    
    

    func getAll() -> [TaskModel]? {

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Task.self)
        //result.sortDescriptors = [NSSortDescriptor(key: "taskName", ascending: true)]

        var tasks : [TaskModel] = []

        result?.forEach({ (cdTask) in
            tasks.append(cdTask.toConvertTask())
        })

        return tasks
    }
    
    

    func get(byIdentifier id: UUID) ->TaskModel? {

        let result = getCDTask(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.toConvertTask()
    }
//
    func update(record: TaskModel) -> Bool {

        let cdTask = getCDTask(byIdentifier: record.id)
        guard cdTask != nil else {return false}

        cdTask?.taskname = record.taskName
        cdTask?.tasktype = record.taskType
       

        PersistentStorage.shared.saveContext()
        return true
    }
    
    
    func delete(byIdentifier id: UUID) -> Bool {

        let task = getCDTask(byIdentifier: id)
        guard task != nil else {return false}

        PersistentStorage.shared.context.delete(task!)
        PersistentStorage.shared.saveContext()

        return true
    }



    private func getCDTask(byIdentifier id: UUID) -> Task?{
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else {return nil}

            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }


    typealias T = TaskModel




}





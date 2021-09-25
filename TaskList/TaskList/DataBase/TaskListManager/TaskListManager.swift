//
//  TaskListManager.swift
//  TaskList
//
//  Created by Muhammad Abdullah Al Mamun on 25/9/21.
//

import Foundation

struct TasklistManager
{
    private let _taskDataRepository = TasklistDataRepository()
    
    func createTask(task: TaskModel) {
        _taskDataRepository.create(record: task)
    }
    
    func fetchTask() -> [TaskModel]? {
        return _taskDataRepository.getAll()
    }
    
    func fetchTask(byIdentifier id: UUID) -> TaskModel?
    {
        return _taskDataRepository.get(byIdentifier: id)
    }
    
    func updateTask(task: TaskModel) -> Bool {
        return _taskDataRepository.update(record: task)
    }
    
    func deleteTask(id: UUID) -> Bool {
        return _taskDataRepository.delete(byIdentifier: id)
    }
}


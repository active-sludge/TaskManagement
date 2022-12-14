//
//  TaskViewModel.swift
//  Task Manager
//
//  Created by Can on 26.10.2022.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    
    // MARK: - New Task Properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    // MARK: - Editing existing task data
    @Published var editTask: Task?
    
    // MARK: - Save Task to Core Data
    func addTask(context: NSManagedObjectContext) -> Bool {
        // MARK: - Updating existing Task Data in Core Data
        var task: Task!
        
        if let editTask = editTask {
            task = editTask
        } else {
            task = Task(context: context)
        }
        
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    func resetTaskData() {
        taskTitle = ""
        taskColor = "Yellow"
        taskDeadline = Date()
        taskType = "Basic"
    }
    
    // If existing task data available then set existing data
    func setupTask() {
        if let editTask = editTask {
            taskTitle = editTask.title ?? ""
            taskColor = editTask.color ?? "Yellow"
            taskType = editTask.type ?? "Basic"
            taskDeadline = editTask.deadline ?? Date()
        }
    }
}

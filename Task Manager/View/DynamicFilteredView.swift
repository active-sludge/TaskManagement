//
//  DynamicFilteredView.swift
//  Task Manager
//
//  Created by Can on 29.10.2022.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View  where T: NSManagedObject {
    // MARK: - Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T) -> Content
    
    // MARK: - Building Custom ForEach which will give CoreData object to build View
    init(currentTab: String, @ViewBuilder content: @escaping (T) -> Content) {
        
        // MARK: - Predicate to filter current date Tasks
        let calendar = Calendar.current
        var predicate: NSPredicate!
        
        if currentTab == "Today" {
            let today = calendar.startOfDay(for: Date())
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
            
            // Filter key
            let filterKey = "deadline"
            
            // Below predicate will fetch tasks between today and tomorrow.
            // 0-false, 1-true
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today, tomorrow, 0])
            
        } else if currentTab == "Upcoming" {
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
            let future = Date.distantFuture
            
            // Filter key
            let filterKey = "deadline"
            
            // Below predicate will fetch tasks between today and tomorrow.
            // 0-false, 1-true
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [tomorrow, future, 0])
        } else if currentTab == "Failed" {
            let today = calendar.startOfDay(for: Date())
            let past = Date.distantPast
            
            // Filter key
            let filterKey = "deadline"
            
            // Below predicate will fetch tasks between today and tomorrow.
            // 0-false, 1-true
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [past, today, 0])
        } else {
            predicate = NSPredicate(format: "isCompleted == %i", argumentArray: [1])
        }
        
        // Initialize request with NSPredicate
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.deadline, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        Group {
            if request.isEmpty {
                Text("No task found!")
            } else {
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
            }
        }
    }
}

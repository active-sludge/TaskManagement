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
}

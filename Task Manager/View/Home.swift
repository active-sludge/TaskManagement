//
//  Home.swift
//  Task Manager
//
//  Created by Can on 26.10.2022.
//

import SwiftUI

struct Home: View {
    @StateObject var taskViewModel: TaskViewModel = .init()
    // MARK: - Matched Geometry Space
    @Namespace var animation
    
    // MARK: - Fetch tasks
    @FetchRequest(entity: Task.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline,
                                                     ascending: false)],
                  predicate: nil,
                  animation: .easeInOut) var tasks: FetchedResults<Task>
    
    // MARK: - Environment Values
    @Environment(\.self) var env
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading,
                       spacing: 8.0, content: {
                    Text("Welcome Back")
                        .font(.callout)
                    Text("Here's Update today")
                        .font(.title.bold())
                })
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding(.vertical)
                
                CustomSegmentedBar()
                    .padding(.top, 5.0)
                
                // MARK: - Task View
                TaskView()
                    .padding(.bottom, 40.0)
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            Button {
                taskViewModel.openEditTask.toggle()
            } label: {
                Label {
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(.vertical, 12.0)
                .padding(.horizontal)
                .background(.black, in: Capsule())
            }
            // Linear Gradient BG
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
            .background {
                LinearGradient(colors: [
                    .white.opacity(0.05),
                    .white.opacity(0.4),
                    .white.opacity(0.7),
                    .white
                ],
                               startPoint: .top,
                               endPoint: .bottom
                )
                .ignoresSafeArea()
            }
        }
        .fullScreenCover(isPresented: $taskViewModel.openEditTask) {
            taskViewModel.resetTaskData()
        } content: {
            AddNewTask()
                .environmentObject(taskViewModel)
        }
    }
    
    // MARK: - Task View
    @ViewBuilder
    func TaskView() -> some View {
        LazyVStack(spacing: 20) {
            ForEach(tasks) { task in
                TaskRowView(task: task)
            }
        }
        .padding(.top, 20.0)
    }
    
    // MARK: - Task Row View
    @ViewBuilder
    func TaskRowView(task: Task) -> some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack {
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Spacer()
                
                // Edit button only for non completed tasks
                if !task.isCompleted {
                    Button {
                        taskViewModel.editTask = task
                        taskViewModel.openEditTask = true
                        taskViewModel.setupTask()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                    }
                }
            }
            
            Text(task.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical, 10.0)
            
            HStack(alignment: .bottom, spacing: 0.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .long,
                                                                 time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .omitted,
                                                                 time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.caption)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if !task.isCompleted {
                    Button {
                        // Updating Core Data
                        task.isCompleted.toggle()
                        try? env.managedObjectContext.save()
                    } label: {
                        Circle()
                            .stroke(.black, lineWidth: 1.5)
                            .frame(width: 25.0, height: 25.0)
                            .contentShape(Circle())
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                .fill(Color(task.color ?? "Yellow"))
        }
    }
    
    // MARK: - Custom Segmented Bar
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Today", "Upcoming", "Task Done"]
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskViewModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 6.0)
                    .frame(maxWidth: .infinity)
                    .background{
                        if taskViewModel.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB",
                                                       in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            taskViewModel.currentTab = tab
                        }
                    }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

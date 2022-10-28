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

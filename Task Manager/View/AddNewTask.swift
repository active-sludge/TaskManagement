//
//  AddNewTask.swift
//  Task Manager
//
//  Created by Can on 26.10.2022.
//

import SwiftUI

struct AddNewTask: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.self) var env
    
    var body: some View {
        VStack(spacing: 12.0) {
            Text("Edit Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
            
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                let sampleCardColors: [String] = ["Yellow", "Green", "Blue", "Purple", "Red", "Orange"]
                
                HStack(spacing: 15.0) {
                    ForEach(sampleCardColors, id: \.self) { color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25.0, height: 25.0)
                            .background {
                                if taskViewModel.taskColor == color {
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-3.0)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                taskViewModel.taskColor = color
                            }
                    }
                }
                .padding(.top, 10.0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30.0)
            
            Divider()
                .padding(.vertical, 10.0)
            
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $taskViewModel.taskTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10.0)
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }

            }
            
            
            Divider()
                .padding(.vertical, 10.0)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        
        
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}

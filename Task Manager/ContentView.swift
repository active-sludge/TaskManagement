//
//  ContentView.swift
//  Task Manager
//
//  Created by Can on 26.10.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

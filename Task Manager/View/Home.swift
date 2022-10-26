//
//  Home.swift
//  Task Manager
//
//  Created by Can on 26.10.2022.
//

import SwiftUI

struct Home: View {
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
            }
            .padding()
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
                    .foregroundColor(.purple)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  TodoView.swift
//  UnitTestingDemo
//
//  Created by Etisha Garg on 29/07/24.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var newTodoTask: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.tasks) { task in
                    Text(task.name)
                }
                .onDelete(perform: deleteTasks)
            }
            
            HStack {
                TextField("Enter a todo task", text: $newTodoTask).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    let task = TodoTask(name: newTodoTask)
                    viewModel.addTask(task: task)
                    newTodoTask = ""
                }) {
                    Text("Add Task")
                }
            }
            .padding()
        }
    }
    
    private func deleteTasks(offsets: IndexSet) {
        offsets.forEach { index in
            viewModel.removeTask(task: viewModel.tasks[index])
        }
    }
}

#Preview {
    TodoView()
}

//
//  TodoViewModel.swift
//  UnitTestingDemo
//
//  Created by Etisha Garg on 29/07/24.
//

import Foundation
import Combine

//Classe que iremos testar:
//se tiver varias classes para serem testadas precisa criar um caso de teste para cada um diferente
class TodoViewModel: ObservableObject {
    @Published var tasks: [TodoTask] = [
        TodoTask(name: "Study Swift"),
        TodoTask(name: "Take pet on a walk"),
        TodoTask(name: "Work on SwiftUI app"),
    ]

    func addTask(task: TodoTask) {
        tasks.append(task)
    }
    
    func removeTask(task: TodoTask) {
        tasks.removeAll { $0.id == task.id }
    }
}

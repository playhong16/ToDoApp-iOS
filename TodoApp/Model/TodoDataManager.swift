//
//  TodoDataManager.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

final class TodoDataManager {
    
    static let shared = TodoDataManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "TodoList"

    private init() {}

    func getTodoList() -> [Todo] {
        if let encodedTodoList = self.userDefaults.object(forKey: key) as? Data,
           let todoList = try? JSONDecoder().decode([Todo].self, from: encodedTodoList) {
            return todoList
        }
        return []
    }
    
    func getComletionList() -> [Todo] {
        var completionList = getTodoList().filter { $0.isCompleted == true }
        return completionList
    }
    
    func getWorkTodo() -> [Todo] {
        let workTodoList = getTodoList().filter { $0.category == .work }
        return workTodoList
    }
    
    func getLifeTodo() -> [Todo] {
        let lifeTodoList = getTodoList().filter { $0.category == .life }
        return lifeTodoList
    }
    
    private func updateUserDefaults(_ todoList: [Todo]) {
        if let encodedTodoList = try? JSONEncoder().encode(todoList) {
            userDefaults.set(encodedTodoList, forKey: key)
        }
    }

    func createTodo(todo: Todo) {
        var todoList = getTodoList()
        todoList.append(todo)
        updateUserDefaults(todoList)
    }

    func deleteTodoList(todo: Todo) {
        var todoList = getTodoList()
        todoList.removeAll { $0.date == todo.date }
        updateUserDefaults(todoList)
    }
}

//
//  TodoDataManager.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

final class TodoDataManager {
    
    static let shared = TodoDataManager()
    private var todoList: [Todo] = []
    
    private init() {}
    
    func getTodoList() -> [Todo] {
        return todoList
    }
    
    func getComletionList() -> [Todo] {
        var completionList: [Todo] = []
        for todo in todoList {
            if todo.isCompleted {
                completionList.append(todo)
            }
        }
        return completionList
    }
    
    func createTodoList(todo: Todo) {
        todoList.append(todo)
    }
    
    func updateTodoList(index: Int, todo: Todo) {
        todoList[index].title = todo.title
        todoList[index].textContent = todo.textContent
        todoList[index].priority = todo.priority
    }
    
    func deleteTodoList(index: Int) {
        todoList.remove(at: index)
    }
    
}

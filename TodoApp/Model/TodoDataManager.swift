//
//  TodoDataManager.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

final class TodoDataManager {
    
    static let shared = TodoDataManager()
    private var todoList: [Todo] = [
        Todo(title: "Swift 문법 마스터하기", textContent: "클로저 공부하기", isCompleted: false, priority: .high),
        Todo(title: "UIKit 프레임워크 공부하기", textContent: "네비게이션 컨트롤러 이해하기", isCompleted: false, priority: .high),
    ]
    
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
    
    func getTodoByDateList(date: Date) -> [Todo] {
        var todoByDateList: [Todo] = []
        for todo in todoList {
            if todo.date == date {
                todoByDateList.append(todo)
            }
        }
        return todoByDateList
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

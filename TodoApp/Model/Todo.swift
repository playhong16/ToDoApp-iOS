//
//  Todo.swift
//  TodoApp
//
//  Created by playhong on 2023/08/07.
//

import Foundation

final class Todo {
    var title: String
    var textContent: String?
    var isCompleted = false
    var priority: TodoPriority?
    
    init(title: String, textContent: String?, isCompleted: Bool = false, priority: TodoPriority?) {
        self.title = title
        self.textContent = textContent
        self.isCompleted = isCompleted
        self.priority = priority
    }
}

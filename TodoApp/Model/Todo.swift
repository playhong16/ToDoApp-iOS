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
    var priority: TodoPriority = .medium
    var date: Date
    var completedTime: String?
    
    init(title: String, textContent: String?, isCompleted: Bool = false, priority: TodoPriority = .medium, date: Date = Date(), completedTime: String? = nil) {
        self.title = title
        self.textContent = textContent
        self.isCompleted = isCompleted
        self.priority = priority
        self.date = date
        self.completedTime = completedTime
    }
    
}

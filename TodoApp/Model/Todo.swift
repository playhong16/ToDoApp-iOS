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
    
    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    init(title: String, textContent: String?, isCompleted: Bool = false, priority: TodoPriority = .medium, date: Date = Date()) {
        self.title = title
        self.textContent = textContent
        self.isCompleted = isCompleted
        self.priority = priority
        self.date = date
    }
    
}

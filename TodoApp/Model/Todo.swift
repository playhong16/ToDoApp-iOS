//
//  Todo.swift
//  TodoApp
//
//  Created by playhong on 2023/08/07.
//

import Foundation

class Todo: Codable {
    var title: String
    var textContent: String?
    var isCompleted = false
    var priority: TodoPriority = .medium
    var date: Date
    var category: TodoCategory
    var completedTime: String?
    
    init(title: String, textContent: String?, isCompleted: Bool = false, priority: TodoPriority = .medium, date: Date = Date(), category: TodoCategory, completedTime: String? = nil) {
        self.title = title
        self.textContent = textContent
        self.isCompleted = isCompleted
        self.priority = priority
        self.date = date
        self.category = category
        self.completedTime = completedTime
    }
}

enum TodoCategory: String, CaseIterable, Codable {
    case life
    case work
}

//
//  Todo.swift
//  TodoApp
//
//  Created by playhong on 2023/08/07.
//

import Foundation

final class Todo {
    var title: String
    var isCompleted = false
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

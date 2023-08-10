//
//  todoDidCreateSegue.swift
//  TodoApp
//
//  Created by playhong on 2023/08/10.
//

import UIKit

class TodoDidCreateSegue: UIStoryboardSegue {
    static let identifier = "TodoDidCreateSegue"
    
    override func perform() {
        super.perform()
    }
    
    func scale() {
        let toViewController = self.destination
        let fromVIewController = self.source
    }
}

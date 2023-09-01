//
//  CompletionListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

final class CompletionListCell: UITableViewCell {
    
    // MARK: - Inteface Builder Outlet

    @IBOutlet weak var completionTodoLabel: UILabel!
    
    // MARK: - Properites

    var completionTodo: Todo? {
        didSet {
            setTodoData()
        }
    }
    
    // MARK: - Setting

    private func setTodoData() {
        completionTodoLabel.text = completionTodo?.title
    }

}

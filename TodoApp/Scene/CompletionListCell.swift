//
//  CompletionListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

final class CompletionListCell: UITableViewCell {
    
    static let identifier = "CompletionListCell"
    
    @IBOutlet weak var completionTodoLabel: UILabel!
    
    var completionTodo: Todo? {
        didSet {
            setupData()
        }
    }
    
    private func setupData() {
        completionTodoLabel.text = completionTodo?.title
    }

}

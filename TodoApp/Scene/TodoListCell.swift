//
//  TodoListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/07.
//

import UIKit

class TodoListCell: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var todo: Todo? {
        didSet {
            setupData()
        }
    }
    
    // MARK: - Setting

    private func setupData() {
        guard let todo = self.todo else { return }
        todoLabel.text = todo.title
        todo.isCompleted ?  setupCompletedCheckButton() : setupCheckButton()
    }
    
    private func setupCheckButton() {
        guard let todo = self.todo else { return }
        todoLabel.textColor = .black
        checkButton.setImage(UIImage(systemName: "app.badge.checkmark"), for: .normal)
        todoLabel.strikethrough(from: todoLabel.text, at: 0)
        todo.isCompleted = false
    }
        
    private func setupCompletedCheckButton() {
        guard let todo = self.todo else { return }
        todoLabel.textColor = .gray
        checkButton.setImage(UIImage(systemName: "app.badge.checkmark.fill"), for: .normal)
        todoLabel.strikethrough(from: todoLabel.text, at: todoLabel.text?.count)
        todo.isCompleted = true
    }

    // MARK: - Action

    @IBAction func checkButtonTapped(_ sender: UIButton) {
        guard let todo = self.todo else { return }
        todo.isCompleted ? setupCheckButton() : setupCompletedCheckButton()
    }
}

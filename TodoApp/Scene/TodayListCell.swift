//
//  TodayListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

class TodayListCell: UITableViewCell {
    
    static let identifier = "TodayListCell"
    
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    
    var todo: Todo? {
        didSet {
            setTodoData()
        }
    }
    
    func setTodoData() {
        guard let todo else { return }
        taskLabel.text = todo.title
        todo.isCompleted ? setUnCompletedTask() : setCompletedTask()
        setDividerColor(priority: todo.priority ?? .medium)
    }
    
    func setCompletedTask() {
        guard let todo = self.todo else { return }
        taskLabel.textColor = .black
        completionButton.setImage(UIImage(systemName: "square"), for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
        divider.backgroundColor = .green
        todo.isCompleted = false
    }
    
    func setUnCompletedTask() {
        guard let todo = self.todo else { return }
        taskLabel.textColor = .gray
        completionButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: taskLabel.text?.count)
        setDividerColor(priority: todo.priority ?? .complete)
        setCompletionButton()
        todo.isCompleted = true
    }
    
    func setDividerColor(priority: TodoPriority) {
        switch priority {
        case .high:
            divider.backgroundColor = .red
        case .medium:
            divider.backgroundColor = .orange
        default:
            print("에러")
        }
    }
    
    func setCompletionButton() {
        completionButton.tintColor = .orange
    }

    @IBAction func completionButtonTapped(_ sender: UIButton) {
        guard let todo else { return }
        todo.isCompleted ? setCompletedTask() : setUnCompletedTask()
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
    }
}

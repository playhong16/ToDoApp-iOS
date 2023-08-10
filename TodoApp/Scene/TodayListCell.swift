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
        setDividerColor(priority: todo.priority)
    }
    
    func setCompletedTask() {
        guard let todo = self.todo else { return }
        taskLabel.textColor = .black
        completionButton.setImage(UIImage(systemName: "square"), for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
        setDividerColor(priority: todo.priority)
    }
    
    func setUnCompletedTask() {
        taskLabel.textColor = .gray
        completionButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: taskLabel.text?.count)
        setDividerColor(priority: .complete)
    }
    
    func setDividerColor(priority: TodoPriority) {
        switch priority {
        case .high:
            divider.backgroundColor = priority.color
            completionButton.tintColor = priority.color
        case .medium:
            divider.backgroundColor = priority.color
            completionButton.tintColor = priority.color
        case .low:
            divider.backgroundColor = priority.color
            completionButton.tintColor = priority.color
        case .complete:
            divider.backgroundColor = priority.color
            completionButton.tintColor = priority.color
        }
    }

    @IBAction func completionButtonTapped(_ sender: UIButton) {
        guard let todo else { return }
        todo.isCompleted ? setCompletedTask() : setUnCompletedTask()
        todo.isCompleted.toggle()
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
    }
}

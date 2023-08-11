//
//  TodayListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

class TodayListCell: UITableViewCell {
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
        todo.isCompleted ? setCompletedTask() : setUnCompletedTask()
    }
    
    func setCompletedTask() {
        taskLabel.textColor = .gray
        completionButton.setImage(UIImage.completionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: taskLabel.text?.count)
        setDividerColor(priority: .complete)
    }
    
    func setUnCompletedTask() {
        guard let todo = self.todo else { return }
        taskLabel.textColor = .black
        completionButton.setImage(UIImage.unComletionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
        setDividerColor(priority: todo.priority)
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

    override func prepareForReuse() {
        super.prepareForReuse()
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
    }
    
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        guard let todo else { return }
        todo.isCompleted ? setUnCompletedTask() : setCompletedTask()
        todo.isCompleted.toggle()
    }
}

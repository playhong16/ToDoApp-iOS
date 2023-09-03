//
//  TodayListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

protocol TodayListCellDelegate: AnyObject {
    func completionButtonTapped(_ todo: Todo)
}

final class TodayListCell: UITableViewCell {
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var completedTimeLabel: UILabel!
    
    // MARK: - Properites

    weak var delegate: TodayListCellDelegate?
    var todo: Todo? {
        didSet {
            setTodoData()
        }
    }
    
    // MARK: - Setting

    private func setTodoData() {
        guard let todo = self.todo else { return }
        taskLabel.text = todo.title
        todo.isCompleted ? setCompletedTodo() : setUnCompletedTodo()
    }
    
    private func setCompletedTodo() {
        taskLabel.textColor = .lightGray
        completionButton.setImage(UIImage.completionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: taskLabel.text?.count)
        setDividerColor(priority: .complete)
        completedTimeLabel.text = "완료 시간: \(setTimeFormat())"
        todo?.completedTime = setTimeFormat()
    }
    
    private func setUnCompletedTodo() {
        guard let todo = self.todo else { return }
        taskLabel.textColor = .black
        completionButton.setImage(UIImage.unComletionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
        setDividerColor(priority: todo.priority)
        completedTimeLabel.text = ""
        todo.completedTime = nil
    }
    
    private func setDividerColor(priority: TodoPriority) {
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
    
    private func setTimeFormat() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.completedTime
        let dateToString = formatter.string(from: date)
        return dateToString
    }
    
    // MARK: - Cell

    override func prepareForReuse() {
        super.prepareForReuse()
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
    }
    
    // MARK: - Interface Builder Action

    @IBAction func completionButtonTapped(_ sender: UIButton) {
        guard let todo else { return }
        todo.isCompleted ? setUnCompletedTodo() : setCompletedTodo()
        todo.isCompleted.toggle()
        delegate?.completionButtonTapped(todo)
    }
    
}

//
//  TodayListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

class TodayListCell: UITableViewCell {
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    
    // MARK: - Properites

    /// [todo] 객체를 전달받기 위해 사용합니다.
    var todo: Todo? {
        didSet {
            setTodoData()
        }
    }
    
    // MARK: - Setting

    /// [todo] 객체를 [TodayViewControll]에서 전달받는 경우 동작합니다.
    func setTodoData() {
        guard let todo = self.todo else { return }
        taskLabel.text = todo.title
        todo.isCompleted ? setCompletedTask() : setUnCompletedTask()
    }
    
    /// [todo] 객체가 [isCompleted == true] 인 경우 동작합니다.
    func setCompletedTask() {
        taskLabel.textColor = .gray
        completionButton.setImage(UIImage.completionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: taskLabel.text?.count)
        setDividerColor(priority: .complete)
    }
    
    /// [todo] 객체가 [isCompleted == false] 인 경우 동작합니다.
    func setUnCompletedTask() {
        guard let todo = self.todo else { return }
        taskLabel.textColor = .black
        completionButton.setImage(UIImage.unComletionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
        setDividerColor(priority: todo.priority)
    }
    
    
    /// [TodoPriority] 에 따라 [divider] 와 [completionButton] 의 색깔을 설정합니다.
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
    
    // MARK: - Cell Configure

    /// TodayViewController의 셀이 재사용될 때 완료되지 않은 todo 객체가 취소선이 생기는 경우를 방지하기 위해 셀을 초기화한다.
    override func prepareForReuse() {
        super.prepareForReuse()
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
    }
    
    // MARK: - Interface Builder Action

    /// [completionButton] 을 누르면 동작합니다.
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        guard let todo else { return }
        todo.isCompleted ? setUnCompletedTask() : setCompletedTask()
        todo.isCompleted.toggle()
    }
    
}

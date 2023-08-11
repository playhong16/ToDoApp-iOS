//
//  TodayListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

final class TodayListCell: UITableViewCell {
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var completedTimeLabel: UILabel!
    
    // MARK: - Properites

    /// [todo] 객체를 전달받기 위해 사용합니다.
    var todo: Todo? {
        didSet {
            setTodoData()
        }
    }
    
    // MARK: - Setting

    /// [todo] 객체를 [TodayViewControll]에서 전달받는 경우 동작합니다.
    private func setTodoData() {
        guard let todo = self.todo else { return }
        taskLabel.text = todo.title
        todo.isCompleted ? setCompletedTodo() : setUnCompletedTodo()
    }
    
    /// [todo] 객체가 [isCompleted == true] 인 경우 동작합니다.
    private func setCompletedTodo() {
        taskLabel.textColor = .lightGray
        completionButton.setImage(UIImage.completionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: taskLabel.text?.count)
        setDividerColor(priority: .complete)
        completedTimeLabel.text = "완료 시간: \(setCompletedTimeFormat())"
        todo?.completedTime = setCompletedTimeFormat()
    }
    
    /// [todo] 객체가 [isCompleted == false] 인 경우 동작합니다.
    private func setUnCompletedTodo() {
        guard let todo = self.todo else { return }
        taskLabel.textColor = .black
        completionButton.setImage(UIImage.unComletionButtonImage, for: .normal)
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
        setDividerColor(priority: todo.priority)
        completedTimeLabel.text = ""
        todo.completedTime = nil
    }
    
    
    /// [TodoPriority] 에 따라 [divider] 와 [completionButton] 의 색깔을 설정합니다.
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
    
    /// 오늘 날짜를 입력받아서 원하는 문자열 포맷으로 변경하고 [completedTimeLabel.text]을 설정합니다.
    private func setCompletedTimeFormat() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.completedTime
        let dateToString = formatter.string(from: date)
        return dateToString
    }
    
    // MARK: - Cell

    /// [TodayViewController]의 Cell이 재사용될 때 [isCompleted == false] 행에서 [taskLabel.text]에 취소선이 생기는 경우를 방지하기 위해 셀을 초기화한다.
    override func prepareForReuse() {
        super.prepareForReuse()
        taskLabel.strikethrough(from: taskLabel.text, at: 0)
    }
    
    // MARK: - Interface Builder Action

    /// [completionButton] 을 누르면 동작합니다.
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        guard let todo else { return }
        todo.isCompleted ? setUnCompletedTodo() : setCompletedTodo()
        todo.isCompleted.toggle()
    }
    
}

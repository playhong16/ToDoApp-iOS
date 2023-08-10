//
//  DetailTodoViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

final class DetailTodoViewController: UIViewController {
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var mediumPriorityButton: UIButton!
    @IBOutlet weak var lowPriorityButton: UIButton!
    
    @IBOutlet var priorityButtons: [UIButton]!
    
    // MARK: - Properties
    
    let todoDataManager = TodoDataManager.shared
    var todo: Todo?
    var priority: TodoPriority = .medium

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigureButton()
        setConfigureTextView()
        setConfigureTextField()
        setTodoData()
        textView.delegate = self
    }
    
    // MARK: - Setting
    
    /// todo 데이터의 상태에 따라 기본 구성을 설정합니다.
    private func setTodoData() {
        if let todo {
            textField.text = todo.title
            textView.text = todo.textContent
            textView.textColor = .black
            setPriorityColor(priority: todo.priority)
        } else {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .lightGray
            textField.placeholder = "내용을 입력해주세요."
            setPriorityColor(priority: .medium)
        }
    }

    
    /// 중요도 버튼의 기본 구성을 설정합니다.
    private func setConfigureButton() {
        for button in priorityButtons {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    /// 텍스트뷰의 기본 구성을 설정합니다.
    private func setConfigureTextView() {
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    /// 텍스트 필드의 기본 구성을 설정합니다.
    private func setConfigureTextField() {
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    /// priority 의 케이스에 따라 버튼의 색깔을 변경할 수 있도록 설정합니다.
    private func setPriorityColor(priority: TodoPriority) {
        switch priority {
        case .high:
            setHighPriorityButton()
        case .medium:
            setMediumPriorityButton()
        case .low:
            setLowPriorityButton()
        case .complete:
            return
        }
    }
    
    /// 중요도 버튼의 색깔을 기본으로 설정합니다.
    private func setClearPriorityColor() {
        for button in priorityButtons {
            button.backgroundColor = .clear
            button.tintColor = .black
        }
    }

    // MARK: - Priority Button Tapped
    
    /// highPriorityButton(높음) 의 색깔을 설정합니다.
    private func setHighPriorityButton() {
        highPriorityButton.backgroundColor = .customOrange
        highPriorityButton.tintColor = .white
    }
    
    /// mediumPriorityButton(중간) 의 색깔을 설정합니다.
    private func setMediumPriorityButton() {
        mediumPriorityButton.backgroundColor = .customYellow
        mediumPriorityButton.tintColor = .white
    }
    
    /// lowPriorityButton(낮음) 의 색깔을 설정합니다.
    private func setLowPriorityButton() {
        lowPriorityButton.backgroundColor = .customGreen
        lowPriorityButton.tintColor = .white
    }
    
    // MARK: - Task on incoming todo data
    
    /// saveButton 동작을 설정합니다.
    private func setSaveButtonAction() {
        if let todo { update(todo: todo) }
        else { addTodo() }
    }
    
    /// todo 데이터를 전달받은 경우 실행합니다.
    private func update(todo: Todo) {
        guard let text = textField.text else { return }
        todo.title = text
        todo.textContent = textView.text
        todo.priority = self.priority
        performSegue(withIdentifier: "todoDidUpdate", sender: todo)
    }
    
    /// todo 데이터를 전달받지 못하고, 새로 생성하는 경우 실행합니다.
    private func addTodo() {
        guard let text = textField.text else { return }
        let todo = Todo(title: text, textContent: textView.text, priority: self.priority)
        todoDataManager.createTodoList(todo: todo)
        performSegue(withIdentifier: "todoDidCreate", sender: nil)
    }
    
    // MARK: - Interface Builder Action
    
    /// 중요도 버튼을 눌렀을 때 tag 를 확인하고, 버튼의 색깔을 중요도에 맞게 설정합니다.
    @IBAction func priorityButtonTapped(sender: UIButton) {
        switch sender.tag {
        case 0:
            priority = .high
            setClearPriorityColor()
            setPriorityColor(priority: priority)
        case 1:
            priority = .medium
            setClearPriorityColor()
            setPriorityColor(priority: priority)
        case 2:
            priority = .low
            setClearPriorityColor()
            setPriorityColor(priority: priority)
        default:
            return
        }
    }
    
    /// '저장' 버튼을 누르면 동작합니다.
    /// - '제목'이 비어있으면, 저장하지 않고 '취소' 버튼이 눌린 것과 동일하게 동작합니다.
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let isEmpty = textField.text?.isEmpty else { return }
        isEmpty ? performSegue(withIdentifier: "cancel", sender: nil) : setSaveButtonAction()
    }
}

// MARK: - Extension

extension DetailTodoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "내용을 입력해주세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .lightGray
        }
    }
}

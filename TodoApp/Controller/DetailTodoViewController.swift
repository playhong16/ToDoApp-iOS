//
//  DetailTodoViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

final class DetailTodoViewController: UIViewController {
    
    // MARK: - Interface Builder Outlet
    
    @IBOutlet var rightBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var mediumPriorityButton: UIButton!
    @IBOutlet weak var lowPriorityButton: UIButton!
    
    @IBOutlet var priorityButtons: [UIButton]!
    
    // MARK: - Properties
    
    /// [TodaDataManager] 싱글톤 객체를 사용합니다.
    private let todoDataManager = TodoDataManager.shared
    
    /// [todo] 객체를 전달받기 위해 사용합니다.
    var todo: Todo?
    
    /// [TodoPriority] 타입의 기본값 설정과 임시 저장을 위해 사용합니다.
    private lazy var priority: TodoPriority = todo?.priority ?? .medium

    // MARK: - Life Cycle
    
    /// 뷰가 로드되면 실행됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTodoData()
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        configureButton()
        configureTextView()
        configureTextField()
    }

    /// [priorityButtons]의 기본 구성을 설정합니다.
    private func configureButton() {
        for button in priorityButtons {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.buttonBorderColor.cgColor 
        }
    }
    
    /// [textView]의 기본 구성을 설정합니다.
    private func configureTextView() {
        textView.delegate = self /// 테이블 뷰의 이벤트를 처리 할 수 있도록 권한을 위임받습니다.
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.buttonBorderColor.cgColor
    }
    
    /// [texField]을 구성합니다.
    private func configureTextField() {
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.buttonBorderColor.cgColor
    }
    
    // MARK: - Setting
    
    /// [todo] 객체의 상태에 따라 기본 구성을 설정합니다.
    private func setTodoData() {
        if let todo {
            textField.text = todo.title
            textView.text = todo.textContent
            textView.textColor = .black
            setPriorityColor()
        } else {
            textView.text = Placeholder.textView
            textView.textColor = .lightGray
            textField.placeholder = Placeholder.textField
            setPriorityColor()
        }
    }
    
    /// [priority] 의 케이스에 따라 버튼의 색깔을 변경할 수 있도록 설정합니다.
    private func setPriorityColor() {
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
    
    /// [priorityButtons]의 색깔을 설정합니다.
    private func setClearPriorityColor() {
        for button in priorityButtons {
            button.backgroundColor = .clear
            button.tintColor = .black
        }
    }

    // MARK: - Priority Button Tapped
    
    /// highPriorityButton(높음) 의 색깔을 설정합니다.
    private func setHighPriorityButton() {
        highPriorityButton.backgroundColor = priority.color
        highPriorityButton.tintColor = .buttonDefaultTintColor
        rightBarButtonItem.tintColor = priority.color
    }
    
    /// [mediumPriorityButton(중간)] 의 색깔을 설정합니다.
    private func setMediumPriorityButton() {
        mediumPriorityButton.backgroundColor = priority.color
        mediumPriorityButton.tintColor = .buttonDefaultTintColor
        rightBarButtonItem.tintColor = priority.color
    }
    
    /// [lowPriorityButton(낮음)] 의 색깔을 설정합니다.
    private func setLowPriorityButton() {
        lowPriorityButton.backgroundColor = priority.color
        lowPriorityButton.tintColor = .buttonDefaultTintColor
        rightBarButtonItem.tintColor = priority.color
    }
    
    /// [priorityButtons]를 눌렀을 때 버튼의 [tag] 를 확인하고, 버튼의 색깔을 [priority]에 맞게 설정합니다.
    @IBAction func priorityButtonTapped(sender: UIButton) {
        switch sender.tag {
        case 0:
            priority = .high
            setClearPriorityColor()
            setPriorityColor()
        case 1:
            priority = .medium
            setClearPriorityColor()
            setPriorityColor()
        case 2:
            priority = .low
            setClearPriorityColor()
            setPriorityColor()
        default:
            priority = .complete
        }
    }
    
    // MARK: - Task on incoming todo data
    
    /// [todo] 객체를 전달받은 경우 [todo] 객체를 수정하는 경우 실행합니다.
    private func update(_ todo: Todo) {
        guard let text = textField.text else { return }
        todo.title = text
        todo.textContent = textView.text
        todo.priority = self.priority
        performSegue(withIdentifier: Identifier.UnwindSegue.updateFromDetailTodoScene, sender: todo)
    }
    
    /// [todo] 객체를 전달받지 못하고, [todo] 객체를 새로 생성하는 경우 실행합니다.
    private func addTodo() {
        guard let text = textField.text else { return }
        let todo = Todo(title: text, textContent: textView.text, priority: self.priority)
        todoDataManager.createTodoList(todo: todo)
        performSegue(withIdentifier: Identifier.UnwindSegue.createFromDetailTodoScene, sender: nil)
    }

    /// [todo] 객체의 존재 여부에 따라 [saveButton]의 동작을 설정합니다.
    private func setSaveButtonAction() {
        if let todo { update(todo) }
        else { addTodo() }
    }
    
    // MARK: - Button Tapped

    /// [saveButton]을 누르면 동작합니다.
    /// - '제목'이 비어있으면, 저장하지 않고 '취소' 버튼이 눌린 것과 동일하게 동작합니다.
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let isEmpty = textField.text?.isEmpty else { return }
        isEmpty ? performSegue(withIdentifier: Identifier.UnwindSegue.cancelFromDetailTodoScene, sender: nil) : setSaveButtonAction()
    }
    
    // MARK: - Other

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Extension

extension DetailTodoViewController: UITextViewDelegate {
    /// [textView]의 편집이 시작될 때 실행됩니다.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Placeholder.textView {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    /// [textView]의 편집이 종료될 때 실행됩니다.
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Placeholder.textView
            textView.textColor = .lightGray
        }
    }
}

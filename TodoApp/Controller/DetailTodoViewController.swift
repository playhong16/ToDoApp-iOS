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
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var mediumPriorityButton: UIButton!
    @IBOutlet weak var lowPriorityButton: UIButton!
    @IBOutlet var priorityButtons: [UIButton]!
    
    // MARK: - Properties
    
    private let todoDataManager = TodoDataManager.shared
    private var categoryMenu: UIMenu {
        let menu = UIMenu(title: "카테고리", children: showCategoryMenu())
        return menu
    }
    private lazy var priority: TodoPriority = todo?.priority ?? .medium
    private lazy var category: TodoCategory = todo?.category ?? .life
    var todo: Todo?
    
    // MARK: - Life Cycle
    
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

    private func configureButton() {
        categoryButton.menu = categoryMenu
        categoryButton.layer.masksToBounds = true
        categoryButton.layer.cornerRadius = 10
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = UIColor.buttonBorderColor.cgColor
        print(category.rawValue)
        for button in priorityButtons {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.buttonBorderColor.cgColor 
        }
    }
    
    private func configureTextView() {
        textView.delegate = self
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.buttonBorderColor.cgColor
    }
    
    private func configureTextField() {
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.buttonBorderColor.cgColor
    }
    
    // MARK: - Setting
    
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
    
    private func setClearPriorityColor() {
        for button in priorityButtons {
            button.backgroundColor = .clear
            button.tintColor = .black
        }
    }

    // MARK: - Priority Button Tapped
    
    private func setHighPriorityButton() {
        highPriorityButton.backgroundColor = priority.color
        highPriorityButton.tintColor = .buttonDefaultTintColor
        rightBarButtonItem.tintColor = priority.color
    }
    
    private func setMediumPriorityButton() {
        mediumPriorityButton.backgroundColor = priority.color
        mediumPriorityButton.tintColor = .buttonDefaultTintColor
        rightBarButtonItem.tintColor = priority.color
    }
    
    private func setLowPriorityButton() {
        lowPriorityButton.backgroundColor = priority.color
        lowPriorityButton.tintColor = .buttonDefaultTintColor
        rightBarButtonItem.tintColor = priority.color
    }
    
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
    
    private func showCategoryMenu() -> [UIAction] {
        let life = UIAction(title: TodoCategory.life.rawValue) { action in
            self.categoryButton.titleLabel?.text = action.title
            self.category = .life
        }
        let work = UIAction(title: TodoCategory.work.rawValue) { action in
            self.categoryButton.titleLabel?.text = action.title
            self.category = .work
        }
        let menuItems = [life, work]
        return menuItems
    }
    
    // MARK: - Todo 객체 처리 작업
    
    private func update(_ todo: Todo) {
        guard let text = textField.text else { return }
        todo.title = text
        todo.textContent = textView.text
        todo.priority = self.priority
        performSegue(withIdentifier: Identifier.UnwindSegue.updateFromDetailTodoScene, sender: todo)
    }
    
    private func addTodo() {
        guard let text = textField.text else { return }
        let todo = Todo(title: text, textContent: textView.text, priority: self.priority, category: self.category)
        todoDataManager.createTodo(todo: todo)
        performSegue(withIdentifier: Identifier.UnwindSegue.createFromDetailTodoScene, sender: category)
    }

    private func setSaveButtonAction() {
        if let todo { update(todo) }
        else { addTodo() }
    }
    
    // MARK: - Button Tapped
    
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
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Placeholder.textView {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Placeholder.textView
            textView.textColor = .lightGray
        }
    }
}

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
    @IBOutlet var priorityButtons: [UIButton]!
    
    // MARK: - Properties
    let todoDataManager = TodoDataManager.shared
    var todo: Todo?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigureButton()
        setConfigureTextView()
        setConfigureTextField()
    }
    
    // MARK: - Setting
    
    private func setTodoData() {
        if let todo {
            self.title = "수정하기"
            textField.text = todo.title
            textView.text = todo.textContent
            textView.textColor = .black
        }
    }

    private func setConfigureButton() {
        for button in priorityButtons {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private func setConfigureTextView() {
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setConfigureTextField() {
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - Priority Button Tapped

    private func highPriorityButtonTapped(sender: UIButton) {
        sender.backgroundColor = .customOrange
        sender.tintColor = .white
    }
    
    private func mediumPriorityButtonTapped(sender: UIButton) {
        sender.backgroundColor = .customYellow
        sender.tintColor = .white
    }
    
    private func lowPriorityButtonTapped(sender: UIButton) {
        sender.backgroundColor = .customGreen
        sender.tintColor = .white
    }
    
    private func setDefaultButton(sender: UIButton) {
        sender.tintColor = .black
        sender.backgroundColor = .white
    }
    
    // MARK: - Interface Builder Action

    @IBAction func priorityButtonTapped(sender: UIButton) {
//        guard let todo else { return }
        switch sender.tag {
        case 0:
            highPriorityButtonTapped(sender: sender)
//            todo.priority = .high
        case 1:
            mediumPriorityButtonTapped(sender: sender)
//            todo.priority = .medium
        case 2:
            lowPriorityButtonTapped(sender: sender)
//            todo.priority = .low
        default:
            print("에러")
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/07.
//

import UIKit

final class TodoListViewController: UITableViewController {
    
    private let todoDataManager = TodoDataManager.shared
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return todoDataManager.getTodoList().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListCell.identifier, for: indexPath) as? TodoListCell else { return UITableViewCell() }
        let todoList = todoDataManager.getTodoList()
        cell.todo = todoList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (action, view, completionHandler) in
            self.todoDataManager.deleteTodoList(index: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // MARK: - Setting
    
    private func setupAlert() {
        let alert = UIAlertController(title: "할 일 추가하기", message: nil, preferredStyle: .alert)
        setupAction(from: alert)
        present(alert, animated: true)
    }
    
    private func setupAction(from alert: UIAlertController) {
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        let add = UIAlertAction(title: "추가", style: .default) { _ in
            let text = alert.textFields?.first?.text
            self.addAlertButtonTapped(text: text)
        }
        alert.addAction(cancel)
        alert.addAction(add)
        alert.addTextField { textField in textField.placeholder = "할 일을 입력하세요."
            textField.delegate = self
        }
    }
    
    private func addAlertButtonTapped(text: String?) {
        guard let text = text else { return }
        todoDataManager.createTodoList(todo: Todo(title: text, textContent: nil, priority: .high))
        let row = todoDataManager.getTodoList().count - 1
        tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
    

    
    // MARK: - Action

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        setupAlert()
    }

}

extension TodoListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if text.count > 10 {
            return false
        }
        return true
    }
}

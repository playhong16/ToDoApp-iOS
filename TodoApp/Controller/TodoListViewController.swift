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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataManager.getTodoList().count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TodoListCell else { return UITableViewCell() }
        let todoList = todoDataManager.getTodoList()
        cell.todo = todoList[indexPath.row]
        return cell
    }
    
    // MARK: - Setting
    
    private func setupAlert() {
        let alert = UIAlertController(title: "할 일 추가하기", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        let add = UIAlertAction(title: "추가", style: .default) { _ in
            let text = alert.textFields?.first?.text
            self.addAlertButtonTapped(text: text)
        }
        alert.addTextField { textField in textField.placeholder = "할 일을 입력하세요." }
        alert.addAction(cancel)
        alert.addAction(add)
        present(alert, animated: true)
    }
    
    private func addAlertButtonTapped(text: String?) {
        guard let text = text else { return }
        todoDataManager.createTodoList(todo: Todo(title: text))
        let rowIndex = todoDataManager.getTodoList().count - 1
        tableView.insertRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
    }
    
    // MARK: - Action

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        setupAlert()
    }
    

}

//
//  TodayViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

final class TodayViewController: UIViewController {
    
    private let todoDataManager = TodoDataManager.shared
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        configureButton()
        configureTableView()
        configureTabBar()
        setDateFormat()
    }
    
    private func configureButton() {
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.buttonBorderColor.cgColor
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureTabBar() {
        tabBarController?.tabBar.layer.borderWidth = 0.5
        tabBarController?.tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - Setting

    private func setDateFormat() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.date
        let dateToString = formatter.string(from: date)
        dateLabel.text = dateToString
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.Segue.toDetailSceneFromTodayScene {
            guard let moveVC = segue.destination as? DetailTodoViewController,
                  let todo = sender as? Todo
            else { return }
            moveVC.todo = todo
        }
        
        if segue.identifier == Identifier.UnwindSegue.createFromDetailTodoScene {
            guard let category = sender as? TodoCategory else { return }
            if category == .life {
                let row = todoDataManager.getLifeTodo().count - 1
                tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            }
            if category == .work {
                let row = todoDataManager.getWorkTodo().count - 1
                tableView.insertRows(at: [IndexPath(row: row, section: 1)], with: .automatic)
            }
        }
    }
    
    // MARK: - Unwind Segue Action
    
    /// [DetailTodoScene] 에서 취소 버튼을 누르면 동작합니다.
    @IBAction func cancelFromDetailTodoScene(_ segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
    
    /// [DetailTodoScene] 에서 [Todo] 객체를 새롭게 만드는 경우 동작합니다.
    @IBAction func createFromDetailTodoScene(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    /// [DetailTodoScene] 에서 [Todo] 객체를 업데이트하는 경우 동작합니다.
    @IBAction func updateFromDetailTodoScene(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
        dismiss(animated: true)
    }
}

// MARK: - Extension

// MARK: - TableView DataSource

extension TodayViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TodoCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return todoDataManager.getLifeTodo().count }
        if section == 1 { return todoDataManager.getWorkTodo().count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.todayList,
                                                       for: indexPath) as? TodayListCell else { return UITableViewCell() }
        if indexPath.section == 0 {
            let todoList = todoDataManager.getLifeTodo()
            cell.todo = todoList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 1 {
            let todoList = todoDataManager.getWorkTodo()
            cell.todo = todoList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return TodoCategory.life.rawValue }
        if section == 1 { return TodoCategory.work.rawValue }
        return "none"
    }
}

// MARK: - TableView Delegate

extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoDataManager.getTodoList()[indexPath.row]
        performSegue(withIdentifier: Identifier.Segue.toDetailSceneFromTodayScene, sender: todo)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: Title.delete) { [weak self] (_, _, _) in
            if indexPath.section == 0 {
                guard let todo = self?.todoDataManager.getLifeTodo()[indexPath.row] else { return }
                self?.todoDataManager.deleteTodoList(todo: todo)
            }
            if indexPath.section == 1 {
                guard let todo = self?.todoDataManager.getWorkTodo()[indexPath.row] else { return }
                self?.todoDataManager.deleteTodoList(todo: todo)
            }
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        delete.title = Title.delete
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

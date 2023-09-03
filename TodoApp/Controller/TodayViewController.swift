//
//  TodayViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

final class TodayViewController: UIViewController {
    
    // MARK: - Properties

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
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
    
    // MARK: - Action

    @IBAction func addButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DetailTodoScene", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailTodoViewController") as? DetailTodoViewController else { return }
        detailViewController.addButtonTapped = { category in
            if category == TodoCategory.life {
                let row = self.todoDataManager.getLifeTodo().count - 1
                self.tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            }
            if category == TodoCategory.work {
                let row = self.todoDataManager.getWorkTodo().count - 1
                self.tableView.insertRows(at: [IndexPath(row: row, section: 1)], with: .automatic)
            }
        }
        present(detailViewController, animated: true)
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
            cell.delegate = self
            return cell
        }
        
        if indexPath.section == 1 {
            let todoList = todoDataManager.getWorkTodo()
            cell.todo = todoList[indexPath.row]
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && !todoDataManager.getLifeTodo().isEmpty { return TodoCategory.life.rawValue }
        if section == 1 && !todoDataManager.getWorkTodo().isEmpty { return TodoCategory.work.rawValue }
        return ""
    }
}

// MARK: - Extension

// MARK: - TableView Delegate

extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailTodoScene", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailTodoViewController") as? DetailTodoViewController else { return }
        let todo = todoDataManager.getTodoList()[indexPath.row]
        detailViewController.todo = todo
        navigationController?.pushViewController(detailViewController, animated: true)
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

// MARK: - TodayListCell Delegate

extension TodayViewController: TodayListCellDelegate {
    func completionButtonTapped(_ todo: Todo) {
        todoDataManager.updateTodo(todo)
    }
}

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
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setConfigureButton()
    }
    
    // MARK: - Setting

    private func setConfigureButton() {
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let moveVC = segue.destination as? DetailTodoViewController,
              let todo = sender as? Todo
        else { return }
        moveVC.todo = todo
    }
    
    // MARK: - Unwind Segue Action

    @IBAction func cancel(_ segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
    
    @IBAction func todoDidCreate(_ segue: UIStoryboardSegue) {
        let row = todoDataManager.getTodoList().count - 1
        tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
    
    @IBAction func todoDidUpdate(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
        dismiss(animated: true)
    }
}

// MARK: - Extension

// MARK: - Table View Data Source

extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataManager.getTodoList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayListCell.identifier,
                                                       for: indexPath) as? TodayListCell else { return UITableViewCell() }
        let todoList = todoDataManager.getTodoList()
        cell.todo = todoList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Table View Delegate

extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoDataManager.getTodoList()[indexPath.row]
        performSegue(withIdentifier: "toDetailTodo", sender: todo)
    }
}

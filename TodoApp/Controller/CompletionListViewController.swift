//
//  CompletionListViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/07.
//

import UIKit

final class CompletionListViewController: UIViewController {
    
    private let todoDataManger = TodoDataManager.shared
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
}

// MARK: - Extension

// MARK: - Table View Data Source

extension CompletionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataManger.getComletionList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.CompletionList, for: indexPath) as? CompletionListCell else { return UITableViewCell() }
        let completionTodoList = todoDataManger.getComletionList()
        cell.completionTodo = completionTodoList[indexPath.row]
        return cell
    }
}

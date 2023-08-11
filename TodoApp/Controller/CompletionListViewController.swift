//
//  CompletionListViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/07.
//

import UIKit

final class CompletionListViewController: UIViewController {
    
    /// [TodaDataManager] 싱글톤 객체를 사용합니다.
    private let todoDataManger = TodoDataManager.shared
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle

    /// [View]가 로드되면 실행됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self /// 테이블 뷰의 데이터를 관리하기 위해 권한을 위임받습니다.
    }
    
    /// [View]가 나타나기 전에 실행됩니다.
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData() /// 테이블 뷰의 행 데이터를 다시 불러와서 표시합니다.
        super.viewWillAppear(animated)
    }
}

// MARK: - Extension

// MARK: - Table View Data Source

extension CompletionListViewController: UITableViewDataSource {
    /// [Table View]의 섹션안에서 [행(Cell)]을 몇 개 사용할지 [Table View]에게 알려줍니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataManger.getComletionList().count
    }
    
    /// 재사용하려는 [Cell]이 무엇인지 [Table View]에게 알려줍니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.CompletionList, for: indexPath) as? CompletionListCell else { return UITableViewCell() }
        let completionTodoList = todoDataManger.getComletionList()
        cell.completionTodo = completionTodoList[indexPath.row]
        return cell
    }
}

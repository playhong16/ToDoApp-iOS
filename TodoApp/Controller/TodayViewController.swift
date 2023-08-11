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

    /// 뷰가 로드되면 실행됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self /// 테이블 뷰의 데이터를 관리하기 위해 권한을 위임받습니다.
        tableView.delegate = self /// 테이블 뷰의 이벤트를 처리 할 수 있도록 권한을 위임받습니다.
        setConfigureButton()
        setDateFomat()
    }
    
    // MARK: - Setting
    
    /// [addButton] 의 기본 구성을 설정합니다.
    private func setConfigureButton() {
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    /// 오늘 날짜를 입력받아서 원하는 문자열 포맷으로 변경하고 dateLabel 을 설정합니다.
    private func setDateFomat() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateToString = formatter.string(from: date)
        dateLabel.text = dateToString
    }
    
    // MARK: - Segue

    /// 테이블 뷰의 셀 선택 시 Todo 를 [DetailTodoVIewController] 로 전달합니다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let moveVC = segue.destination as? DetailTodoViewController,
              let todo = sender as? Todo
        else { return }
        moveVC.todo = todo
    }
    
    // MARK: - Unwind Segue Action
    
    /// [DetailTodoScene] 에서 취소 버튼을 누르면 동작합니다.
    @IBAction func cancel(_ segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
    
    /// [DetailTodoScene] 에서 Todo 를 새롭게 만드는 경우 동작합니다.
    @IBAction func todoDidCreate(_ segue: UIStoryboardSegue) {
        let row = todoDataManager.getTodoList().count - 1
        tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
    
    /// [DetailTodoScene] 에서 Todo 를 업데이트하는 경우 동작합니다.
    @IBAction func todoDidUpdate(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
        dismiss(animated: true)
    }
}

// MARK: - Extension

// MARK: - Table View Data Source

extension TodayViewController: UITableViewDataSource {
    /// 테이블 뷰의 섹션안에서 행(Cell)을 몇 개 사용할지 테이블 뷰에게 알려줍니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataManager.getTodoList().count
    }
    
    /// 재사용하려는 셀이 무엇인지 테이블 뷰에게 알려줍니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.todayList,
                                                       for: indexPath) as? TodayListCell else { return UITableViewCell() }
        let todoList = todoDataManager.getTodoList()
        cell.todo = todoList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: - Table View Delegate

extension TodayViewController: UITableViewDelegate {
    /// 테이블 뷰의 행(Cell)을 선택하면 실행합니다.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoDataManager.getTodoList()[indexPath.row]
        performSegue(withIdentifier: "toDetailTodo", sender: todo)
    }
    
    /// 테이블 뷰 행(Cell)의 trailing 끝에 표시하려는 스와이프 동작을 나타냅니다.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: Title.delete) { (action, view, completionHandler) in
            self.todoDataManager.deleteTodoList(index: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
        delete.backgroundColor = .red
        delete.title = Title.delete
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

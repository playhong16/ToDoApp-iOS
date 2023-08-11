//
//  TodayViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

final class TodayViewController: UIViewController {
    
    /// [TodaDataManager] 싱글톤 객체를 사용합니다.
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
        setDateFormat()
    }
    
    // MARK: - Setting
    
    /// [addButton] 의 기본 구성을 설정합니다.
    private func setConfigureButton() {
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.buttonBorderColor.cgColor
    }
    
    /// 오늘 날짜를 입력받아서 원하는 문자열 포맷으로 변경하고 [dateLabel.text] 을 설정합니다.
    private func setDateFormat() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.date
        let dateToString = formatter.string(from: date)
        dateLabel.text = dateToString
    }
    
    // MARK: - Segue

    /// [Segue]를 실행하기 전에 수행해야하는 동작들을 처리합니다.
    /// [Segue]의 Destination(목적지)가 [DetailTodoViewController]일 때 [sender] 파라미터에 [Todo] 객체가 담겨있다면, [DetailTodoViewController] 의 [todo] 저장 속성에 [sender] 의 [todo] 를 담는다.
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
    
    /// [DetailTodoScene] 에서 [Todo] 객체를 새롭게 만드는 경우 동작합니다.
    @IBAction func todoDidCreate(_ segue: UIStoryboardSegue) {
        let row = todoDataManager.getTodoList().count - 1
        tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
    
    /// [DetailTodoScene] 에서 [Todo] 객체를 업데이트하는 경우 동작합니다.
    @IBAction func todoDidUpdate(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
        dismiss(animated: true)
    }
}

// MARK: - Extension

// MARK: - Table View Data Source

extension TodayViewController: UITableViewDataSource {
    /// [Table View]의 섹션안에서 [행(Cell)]을 몇 개 사용할지 [Table View]에게 알려줍니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataManager.getTodoList().count
    }
    
    /// 재사용하려는 [Cell]이 무엇인지 [Table View]에게 알려줍니다.
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
    /// [Table View]의 [행(Cell)]을 선택하면 실행합니다.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoDataManager.getTodoList()[indexPath.row]
        performSegue(withIdentifier: Identifier.Segue.toDetailSceneFromTodayScene, sender: todo)
    }
    
    /// [Table View]의 [행(Cell)] trailing 끝에 표시하려는 스와이프 동작을 나타냅니다.
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

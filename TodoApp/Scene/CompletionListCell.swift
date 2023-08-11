//
//  CompletionListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

final class CompletionListCell: UITableViewCell {
    
    // MARK: - Inteface Builder Outlet

    @IBOutlet weak var completionTodoLabel: UILabel!
    
    // MARK: - Properites
    
    // 완료된 [todo] 객체를 전달받기 위해 사용합니다.
    var completionTodo: Todo? {
        didSet {
            setTodoData()
        }
    }
    
    // MARK: - Setting

    /// [todo] 객체를 [CompletionListViewControll]에서 전달받는 경우 동작합니다.
    private func setTodoData() {
        completionTodoLabel.text = completionTodo?.title
    }

}

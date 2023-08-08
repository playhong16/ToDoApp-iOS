//
//  CompletionListCell.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

class CompletionListCell: UITableViewCell {
    
    static let identifier = "CompletionListCell"
    
    @IBOutlet weak var completionTodoLabel: UILabel!
    
    var completionTodo: Todo? {
        didSet {
            setupData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData() {
        completionTodoLabel.text = completionTodo?.title
    }

}

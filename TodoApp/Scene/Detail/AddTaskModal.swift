//
//  AddTaskModal.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

class AddTaskModal: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    init() {
        super.init(nibName: "AddTaskModal", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        backgroundView.alpha = 0
        contentView.alpha = 0
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 13
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false)
        show()
    }
    
    func show() {
        UIView.animate(withDuration: 1, delay: 0.5) {
            self.backgroundView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
    
}

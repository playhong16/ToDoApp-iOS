//
//  StartViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/09/01.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Properties

    let url = "https://spartacodingclub.kr/css/images/scc-og.jpg"
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: self.url) else { return }
        mainImageView.loadImage(url: url)
    }
    
    // MARK: - Action

    @IBAction func startButtonTapped(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "TodayScene", bundle: nil)
        guard let mainViewController = mainStoryboard.instantiateInitialViewController() else { return }
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true)
    }
    
}

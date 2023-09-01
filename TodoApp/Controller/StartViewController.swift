//
//  StartViewController.swift
//  TodoApp
//
//  Created by playhong on 2023/09/01.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    let url = "https://spartacodingclub.kr/css/images/scc-og.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: self.url) else { return }
        mainImageView.loadImage(url: url)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "TodayScene", bundle: nil)
        guard let mainViewController = mainStoryboard.instantiateInitialViewController() else { return }
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true)
    }
    
}

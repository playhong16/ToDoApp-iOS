//
//  UILabel.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

extension UILabel {
    /// [UILabe.text] 에 취소선을 그릴 때 사용합니다.
    func strikethrough(from text: String?, at range: Int?) {
        guard let text = text, let range = range else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                      range: NSMakeRange(0, range))
        self.attributedText = attributedString
    }
}

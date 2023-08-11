//
//  UIColor.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

extension UIColor {
    /// [TodoPriority] 의 단계 별 색깔을 표시하기 위해 사용합니다.
    /// customRed == .high, customYellow == .medium, customGrren == .low
    static let customRed = UIColor(red: 240/255, green: 113/255, blue: 103/255, alpha: 1)
    static let customYellow = UIColor(red: 255/255, green: 214/255, blue: 112/255, alpha: 1)
    static let customGreen = UIColor(red: 153/255, green: 217/255, blue: 140/255, alpha: 1)
    
    /// UIButton 들의 테두리 색깔입니다.
    static let buttonBorderColor = UIColor.lightGray
}

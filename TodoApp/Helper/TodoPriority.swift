//
//  TodoPriority.swift
//  TodoApp
//
//  Created by playhong on 2023/08/09.
//

import UIKit

enum TodoPriority {
    case high
    case medium
    case low
    case complete
    
    var color: UIColor {
        switch self {
        case .high:
            return UIColor.customOrange
        case .medium:
            return UIColor.customYellow
        case .low:
            return UIColor.customGreen
        case .complete:
            return UIColor.green
        }
    }
}

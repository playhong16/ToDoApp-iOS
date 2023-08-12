//
//  Constant.swift
//  TodoApp
//
//  Created by playhong on 2023/08/11.
//

import Foundation

enum Title {
    static let delete = "삭제"
}

enum Placeholder {
    static let textField = "할 일을 입력하세요."
    static let textView = "내용을 입력하세요."
}

enum Identifier {
    enum Cell {
        static let todayList = "TodayListCell"
        static let CompletionList = "CompletionListCell"
    }
    
    enum Segue {
        static let toDetailSceneFromAddButton = "toDetailSceneFromAddButton"
        static let toDetailSceneFromTodayScene = "toDetailSceneFromTodayScene"
    }
    
    enum UnwindSegue {
        static let cancelFromDetailTodoScene = "cancelFromDetailTodoScene"
        static let createFromDetailTodoScene = "createFromDetailTodoScene"
        static let updateFromDetailTodoScene = "updateFromDetailTodoScene"
    }
}

enum DateFormat {
    static let date = "yyyy-MM-dd"
    static let completedTime = "HH시 mm분"
}

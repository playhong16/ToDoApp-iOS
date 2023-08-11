//
//  TodoDataManager.swift
//  TodoApp
//
//  Created by playhong on 2023/08/08.
//

import UIKit

final class TodoDataManager {
    
    /// TodoDataManager 를 싱글톤 객체로 만들어서 사용합니다.
    /*
     [TodoDataManager] 객체를 생성해서 'shared' 상수에 담고,
     필요한 경우 'shared' 에 접근해서 TodoDataManager 객체와 상호작용을 합니다.
    */
    static let shared = TodoDataManager()
    
    private var todoList: [Todo] = [
        Todo(title: "Swift 문법 마스터하기", textContent: "클로저 공부하기", isCompleted: false, priority: .high),
        Todo(title: "UIKit 프레임워크 공부하기", textContent: "네비게이션 컨트롤러 이해하기", isCompleted: false, priority: .high),
    ]
    
    /// TodoDataManager 를 하나의 객체만 만들어서(싱글톤 패턴) 사용하기 위해 생성자의 접근을 제어합니다.
    private init() {}
    
    /// [todoList]를 반환합니다.
    func getTodoList() -> [Todo] {
        return todoList
    }
    
    /// [isCompleted == true] [Todo] 객체를 담은 [completionList]을 반환합니다. - 고차함수를 사용해서 코드 리팩토링이 가능하다.
    func getComletionList() -> [Todo] {
        var completionList: [Todo] = []
        for todo in todoList {
            if todo.isCompleted {
                completionList.append(todo)
            }
        }
        return completionList
    }
    
//    func getTodoByDateList(date: Date) -> [Todo] {
//        var todoByDateList: [Todo] = []
//        for todo in todoList {
//            if todo.date == date {
//                todoByDateList.append(todo)
//            }
//        }
//        return todoByDateList
//    }
    
    /// [todoList]에 [Todo] 객체를 추가합니다.
    func createTodoList(todo: Todo) {
        todoList.append(todo)
    }
    
    /// [todoList]에서 [Todo] 객체를 삭제합니다.
    func deleteTodoList(index: Int) {
        todoList.remove(at: index)
    }
    
}

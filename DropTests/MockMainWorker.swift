//
//  MockMainWorker.swift
//  DropTests
//
//  Created by Emre Değirmenci on 17.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
@testable import Drop

class MainWorkerSpy: MainWorker {
    var fetchTodosCalled = false
    var todos: [Todo]
    init(todos : [Todo] = []) {
        self.todos = todos
    }

    override func fetchTodayInTodos(completion: @escaping (Result<[Todo], Error>) -> ()) {
        fetchTodosCalled = true
        completion(.success(todos))
    }
}

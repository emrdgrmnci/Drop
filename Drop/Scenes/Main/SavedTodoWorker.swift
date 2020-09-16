//
//  SavedTodoWorker.swift
//  Drop
//
//  Created by Emre Değirmenci on 16.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

final class SavedTodoWorker {

    var todos = [String: Bool]()

    func saveTodo(completion: @escaping (Result<[String: Bool], Error>) -> ()) {
        if let result = UserDefaults.standard.dictionary(forKey: "id") as? [String: Bool] {
            todos = result
            completion(.success(todos))
        }
    }

    func setCompleted(id: String, completed: Bool) {
        todos[id] = completed
        saveID()
    }

    func saveID() {
        UserDefaults.standard.set(todos, forKey: "id")
    }

    func getID() -> Int? {
        return UserDefaults.standard.integer(forKey: "id")
    }
}
